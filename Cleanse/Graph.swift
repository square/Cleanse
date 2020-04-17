//
//  Graph.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/26/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

private class FutureProvider {
    let instanceProvidesType: Any.Type
    var actualProvider: AnyProvider?

    init(providesType: Any.Type) {
       self.instanceProvidesType = providesType
    }
    
    func getAny() -> Any {
        return actualProvider!.getAny()
    }
    
    func resolve(actualProvider: AnyProvider) {
        precondition(actualProvider.instanceProvidesType == instanceProvidesType, "Expected new value to have a provider type of \(instanceProvidesType) instead it has \(actualProvider.instanceProvidesType)")
        self.actualProvider = actualProvider
    }
}

/// Contents of an object graph. Also the "Binder" object
class Graph : BinderBase {
    fileprivate var requirements = Dictionary<RequirementKey, [ProviderRequestDebugInfo]>()
    
    fileprivate var futureProviders = Dictionary<RequirementKey, FutureProvider>()

    /// Keyeed by type of value
    fileprivate var providers = Dictionary<RequirementKey, AnyProvider>()
    
    /// Values of outer array are values that contain () -> Type
    fileprivate var collectionProviders = Dictionary<CollectionProvidersKey, [AnyProvider]>()
    
    fileprivate var finalizables = [Finalizable]()
    
    fileprivate var parent: Graph?

    fileprivate let scope: Scope.Type?

    private var seenModules = Set<SeenModuleKey>()
    
    init(scope: Scope.Type?, parent: Graph?=nil) {
        self.scope = scope
        self.parent = parent
    }
    
    var finalized = false
    
    func _internalBind(binding: RawProviderBinding) {

        let scopedProvider: AnyProvider

        if let scope = binding.scope {
            // TODO: Improve error handling
            precondition(scope == self.scope, "Can only bind things with same scope.")
            scopedProvider = scopeProvider(provider: binding.provider)
        } else {
            scopedProvider = binding.provider
        }
        
        if binding.isCollectionProvider {
            addCollectionProvider(provider: scopedProvider, mergeFunc: binding.collectionMergeFunc!)
        } else {
            addProvider(provider: scopedProvider)
        }
    }
    
    
    private func findOrCreateFutureProvider<Element>(type: Element.Type, debugInfo: ProviderRequestDebugInfo) -> Provider<Element> {
        guard let type = type as? AnyProvider.Type else {
            return findOrCreateFutureProvider(type: Provider<Element>.self, debugInfo: debugInfo).flatten(Element.self)
        }

        let key: RequirementKey

        if let type = type as? AnyWeakProvider.Type {
            key = .init(type.standardProviderType)
        } else {
            key = .init(type)
        }
        
        let futureProvider: FutureProvider

        if let existing = self.futureProviders[key] {
            futureProvider = existing
        } else {
            futureProvider = FutureProvider(providesType: ((type as? AnyWeakProvider.Type)?.standardProviderType.providesType ?? type.providesType))
            self.futureProviders[key] = futureProvider
        }

        requirements[key] = (requirements[key] ?? []) + [debugInfo]

        if type is AnyWeakProvider.Type {
            return Provider(value: type.makeNew(getter: { [weak futureProvider] in
                 futureProvider?.getAny() as Any
            }) as! Element)
        } else {
            return Provider(value: type.makeNew(getter: { futureProvider.getAny() }) as! Element)
        }
        
    }

    private func addProvider(provider: AnyProvider) {
        /// If Tag is a _VoidTag, then we want to add it as a provider without the tagged type
        let key = RequirementKey(type(of: provider))

        if let existingKey = providers[key] {
            fatalError("Already bound at \(existingKey.instanceProvidesType)")
        }

        providers[key] = provider
        
        if let getterProvider = provider.anyGetterProvider {
            providers[RequirementKey(type(of: getterProvider))] = getterProvider
        }
        
        #if SUPPORT_LEGACY_OBJECT_GRAPH
            
        self.maybeAddLegacyProviders(provider: provider)
        
        #endif
    }
    
    /// Add provider for elements of a collection
    private func addCollectionProvider(provider: AnyProvider, mergeFunc: @escaping ([Any]) -> Any) {
        let collectionProviderKey: CollectionProvidersKey
        
        collectionProviderKey = .init(type(of: provider))
        
        if collectionProviders[collectionProviderKey] == nil {
            finalizables.append(AnonymousFinalizable {
                let collectionProviders = self.gatherAllCollectionProviders(key: collectionProviderKey)
                
                let aggregatedProvider = type(of: provider).makeNew {
                    let values = collectionProviders.map { $0.getAny() }
                    return mergeFunc(values)
                }
                
                self.addProvider(provider: aggregatedProvider)
            })
            
            collectionProviders[collectionProviderKey] = []
        }
        
        collectionProviders[collectionProviderKey]!.append(provider)
    }

    private func gatherAllCollectionProviders(key: CollectionProvidersKey) -> [AnyProvider] {
        var collectionProviders = self.collectionProviders[key]!

        var curGraph: Graph = self
        while let graph = curGraph.parent {

            if let graphCollectionProviders = graph.collectionProviders[key] {
                collectionProviders += graphCollectionProviders
            }

            curGraph = graph
        }

        return collectionProviders
    }
    /// Wraps a provider in a scope if necessary
    private func scopeProvider(provider: AnyProvider) -> AnyProvider {
            let scopedProviderCls = ScopedProvider(rawProvider: provider)
        
            return scopedProviderCls.wrappedProvider
    }

    
    func _internalProvider<Element>(_ type: Element.Type, debugInfo: ProviderRequestDebugInfo?) -> Provider<Element> {
        precondition(!finalized, "Cannot call \(#function) after finalize is called")

        let newRequirements = debugInfo ?? ProviderRequestDebugInfo(requestedType: type, providerRequiredFor: nil, sourceLocation: nil)

        let futureProvider = self.findOrCreateFutureProvider(type: type, debugInfo: newRequirements)
        return futureProvider.asCheckedProvider(Element.self)
    }
    
    private func maybeBindCanonical(keyType: Any.Type) -> AnyProvider? {
        if let keyType = keyType as? AnyProvider.Type {
            return maybeBindCanonical(keyType: keyType.providesType)
        }
        
        guard let keyType = keyType as? AnyCanonicalRepresentable.Type else {
            return nil
        }
        
        
        if let canonicalProvider = providers[RequirementKey(keyType.canonicalProviderType)] {
            return keyType.transformFromCanonicalAnyCanonical(canonicalProvider: canonicalProvider)
        }
        
        /// If we get here, check if we want to bind it

        if let childP = maybeBindCanonical(keyType: keyType.canonicalProviderType) {
            return keyType.transformFromCanonicalAnyCanonical(canonicalProvider: childP)
        }
    
        return nil
    }
    
    /// This must be called beforethe graph is used
    func finalize() throws {
        precondition(!finalized, "Cannot call \(#function) more than once")
        
        var errors = [CleanseError]()
        
        try finalizables.forEach { try $0.finalize() }
        finalizables.removeAll()
        
        // Add any canonical type mappings if needed
        for key in requirements.keys where getRegisteredProvider(key: key) == nil {
            let keyType = (key.type as! AnyProvider.Type)
            
            if let p = maybeBindCanonical(keyType: keyType.providesType) {
                providers[key] = p
            }
        }
        
        // We may also need to add a provider of ourselves. This is needed for subcomponents.

        #if SUPPORT_LEGACY_OBJECT_GRAPH
            let legacyObjectGraphKey = RequirementKey(Provider<LegacyObjectGraph>.self)
                
            if self.requirements[legacyObjectGraphKey] != nil && self.providers[legacyObjectGraphKey] == nil {
                self.providers[legacyObjectGraphKey] = Provider<LegacyObjectGraph> {  [weak self] in LegacyObjectGraph(graph: self!) }
            }
        #endif

        
        // TODO: validate cycles
        
        // TODO: validate individual object graphs
        for r in futureProviders.keys {
            if getRegisteredProvider(key: r) == nil {
                errors.append(MissingProvider(requests: requirements[r]!))
            }
        }
        
        switch errors.count {
        case 0:
            // Everything is cool
            break
        case 1:
            throw errors[0]
        default:
            throw MultiError(errors: errors)
        }

        for (k,v) in self.futureProviders {
            v.resolve(actualProvider: getRegisteredProvider(key: k)!)
        }
        
        finalized = true
    }

    func include<M: Module>(module: M.Type) {
        let key = SeenModuleKey(module)
        guard !seenModules.contains(key) else {
            return
        }
        module.configure(binder: .init(binder: self))
        seenModules.insert(key)
    }

    private func install<C: ComponentBase>(componentBase dependency: C.Type) {
        self.bind(ComponentFactory<C>.self)
            .to(factory: { [weak self] in
                return ComponentFactory(parent: self) { seed, subgraph in
                    // If the seeds a provider we need to bind it differently
                    if let seed = seed as? AnyProvider {
                        subgraph._internalBind(binding: RawProviderBinding(
                            scope: nil,
                            provider: seed,
                            collectionMergeFunc:  nil,
                            sourceLocation: nil
                        ))
                    } else {
                        subgraph._internalBind(binding: RawProviderBinding(
                            scope: nil,
                            provider: Provider(value: seed),
                            collectionMergeFunc:  nil,
                            sourceLocation: nil
                        ))
                    }

                    let rootProvider = subgraph.provider(C.Root.self)

                    dependency.configure(binder: .init(binder: subgraph))
                    subgraph.bind(C.Root.self).configured(with: C.configureRoot)

                    try! subgraph.finalize()

                    return rootProvider.get()
                }
            })
    }


    func install<C : RootComponent>(dependency: C.Type) {
        install(componentBase: dependency)
    }

    func install<C : Component>(dependency: C.Type) {
        install(componentBase: dependency)
    }
    
    // For use in finalize. Gets our provider, or recurses up to the parent's
    private func getRegisteredProvider(key: RequirementKey) -> AnyProvider? {
        return self.providers[key] ?? parent?.getRegisteredProvider(key: key)
    }
    
    // MARK: Legacy support
    
    #if SUPPORT_LEGACY_OBJECT_GRAPH
    
    private var legacyKeyToKey = Dictionary<LegacyKey, AnyProvider.Type>()
    private var legacyPropertyInjectors = Dictionary<RequirementKey, (AnyObject) -> Void>()
    
    private func maybeAddLegacyProviders(provider: AnyProvider) {
        /// Hack for Legacy Injection

        let tag: _AnyTag.Type?
        if let taggedProvider = provider as? AnyTaggedProvider {
            tag = type(of: taggedProvider).tag
        } else {
            tag = nil
        }

        if provider.instanceProvidesType is AnyClass || provider.instanceProvidesType == String.self {
            let legacyKey = LegacyKey(cls: provider.instanceProvidesType, name: tag?.legacyName)
            precondition(legacyKeyToKey[legacyKey] == nil)
            legacyKeyToKey[legacyKey] = type(of: provider)
        }
        
        if let propertyInjectorType = provider.instanceProvidesType as? AnyPropertyInjectorProtocol.Type {
            legacyPropertyInjectors[RequirementKey(propertyInjectorType.injectedType)] = (provider.getAny() as! AnyPropertyInjectorProtocol).untypedInjectProperties
        }
    }
    
    func legacyProvider(cls: Any.Type, name: String?) -> Provider<AnyObject> {
        let legacyKey = LegacyKey(cls: cls, name: name)
        
        let rawProvider: AnyProvider
        
        if let providerKey = legacyKeyToKey[legacyKey], let provider = self.providers[RequirementKey(providerKey)] {
            rawProvider = provider
        } else if let canonicalCls = cls as? AnyCanonicalRepresentable.Type,
                let providerKey = legacyKeyToKey[LegacyKey(cls: canonicalCls.canonicalProviderType.providesType, name: name)],
                let canonicalProvider = self.providers[RequirementKey(providerKey)] {
            rawProvider = canonicalCls.transformFromCanonicalAnyCanonical(canonicalProvider: canonicalProvider)
        } else {
            preconditionFailure("Could not find legacy provider for \(cls) named \(String(describing: name))")
        }
        
        if name == nil {
            return rawProvider.map { $0 as AnyObject }
        }
        
        return rawProvider
            .map { $0 as AnyObject }
    }
    
    func legacyPropertyInjector(cls: AnyObject.Type) -> (AnyObject) -> Void  {
        precondition(cls is NSObject.Type, "Can only do legacy property injection for NSObjects")
        
        var foundPropertyInjectors = Array<(AnyObject) -> Void>()
        
        var curCls: NSObject.Type! = cls as! NSObject.Type
        
        while curCls != nil {
            if let pi = legacyPropertyInjectors[RequirementKey(curCls)] {
                foundPropertyInjectors.append(pi)
            }
            
            if let superCls = curCls.superclass() {
                curCls = superCls as! NSObject.Type
            } else {
                curCls = nil
            }
        }

        precondition(foundPropertyInjectors.count > 0, "Could not find property legacy property injectors for \(cls)")
        
        return { (o: AnyObject) in
            /// Iterate through all the found property injectors starting at the most root class and iterating to child classes
            for pi in foundPropertyInjectors.reversed() {
                pi(o)
            }
        }
    }
    
    #endif
}

extension Graph : CustomDebugStringConvertible {
    var debugDescription: String {
        var result = "Bound Providers Keys:"
        
        for p in self.providers.keys {
            result += "\n  * \(p.description)"
        }
        
        return result
    }
}

/// Helper function to pull out the alternate provider variant.
/// This is basicall so we can have Tagged<() -> Date, Now> injected into us
private protocol AlternateVariantTaggedValue {
    static func addAlternateProviderToGraph<Element>(provider: Provider<Element>, graph: Graph)
}


/// MARK: Helpers to key things by type and have good debug representations

private struct RequirementKey : TypeKeyProtocol {
    typealias TT = Any
    
    let type: TT.Type
    
    init(_ type: TT.Type) {
        self.type = type
    }
}


private struct SeenModuleKey : TypeKeyProtocol {
    typealias TT = Any

    let type: TT.Type

    init(_ type: TT.Type) {
        self.type = type
    }
}

private struct CollectionProvidersKey : TypeKeyProtocol {
    typealias TT = Any

    let type: TT.Type
    
    init(_ type: TT.Type) {
        self.type = type
    }
}


