//
//  ValidationVisitor.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/19/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


extension ProviderProtocol {
    fileprivate static var providerToClosureType: Provider<() -> Element>.Type {
        return Provider<() -> Element>.self
    }
}

extension AnyProvider where Self: ProviderProtocol {
    static var anyProviderToClosureType: AnyProvider.Type {
        return providerToClosureType
    }
}


public struct ProviderKey : TypeKeyProtocol {
    let ctype: AnyProvider.Type

    public var type: Any.Type {
        return ctype
    }

    init(_ type: AnyProvider.Type) {
        self.ctype = type
    }
}


public class ProviderInfo : DelegatedHashable, CustomStringConvertible {
    let rawBinding: RawProviderBinding
    var requirements: Set<ProviderKey> = []

    init(rawBinding: RawProviderBinding) {
        self.rawBinding = rawBinding
    }

    public var hashable: ObjectIdentifier {
        return ObjectIdentifier(self)
    }

    public var description: String {
        return "ProviderInfo for \(type(of: rawBinding.provider))"
    }
}

private class ComponentInfo: ComponentBinding {
    let scope: Scope.Type?
    let seed: Any.Type
    let isRootComponent: Bool
    let componentType: Any.Type?
    
    var parent: ComponentBinding? {
        return parentInfo
    }
    
    var subcomponents: [ComponentBinding] {
        return subcomponentsInfo
    }

    weak var parentInfo: ComponentInfo?

    var subcomponentsInfo: [ComponentInfo] = []

    var providers = [ProviderKey: [ProviderInfo]]()

    var providerAliases = [ProviderKey: ProviderKey]()

    fileprivate var cycleCheckedProviders = Set<ProviderInfo>()

    init(scope: Scope.Type?, seed: Any.Type, isRootComponent: Bool, parent: ComponentInfo?, componentType: Any.Type?) {
        self.isRootComponent = isRootComponent
        self.scope = scope
        self.seed = seed
        self.parentInfo = parent
        self.componentType = componentType
    }

    fileprivate func validate(_ errors: inout [CleanseError]) {
        validateNestedScopes(&errors)

        for p in providers.values.joined() {
            validate(provider: p, errors: &errors)
        }
    }

    fileprivate func validateNestedScopes(_ errors: inout [CleanseError]) {
        if scope == nil {
            return
        }

        var loopCurrent = parentInfo
        while let current = loopCurrent {
            if current.scope == scope {
                errors.append(InvalidScopeNesting(scope: scope!, innerComponent: self.componentType!, outerComponent: current.componentType!))
            }
            loopCurrent = current.parentInfo
        }
    }

    fileprivate func validate(provider providerInfo:  ProviderInfo, errors: inout [CleanseError]) {
        for r in providerInfo.requirements {
            validate(requirement: r, providerInfo: providerInfo, errors: &errors)
        }

        do {
            try validateCycles(providerKey: ProviderKey(type(of: providerInfo.rawBinding.provider)), providerInfo: providerInfo)
        } catch let e as CleanseError {
            errors.append(e)
        } catch {
            preconditionFailure("Unexpected Error")
        }
    }

    // Once we find one cycle, stop (hence throwing instead of appending to a list of errors)
    fileprivate func validateCycles(providerKey: ProviderKey, providerInfo:  ProviderInfo) throws {

        var providerStack = [(ProviderKey, ProviderInfo)]()
        var providersInStack = Set<ProviderInfo>()

        try self.validateCycles(
            providerKey: providerKey,
            providerInfo: providerInfo,
            providerStack: &providerStack,
            providersInStack: &providersInStack
        )
    }

    fileprivate func validateCycles(providerKey: ProviderKey, providerInfo:  ProviderInfo, providerStack: inout [(ProviderKey, ProviderInfo)], providersInStack: inout Set<ProviderInfo>) throws {
        if cycleCheckedProviders.contains(providerInfo) {
            return
        }

        defer {
            cycleCheckedProviders.insert(providerInfo)
        }

        guard !providersInStack.contains(providerInfo) else {
            let providerStack = providerStack.suffix(from: providerStack.firstIndex { $1 == providerInfo }!) + [(providerKey, providerInfo)]

            var debugInfos = [ProviderRequestDebugInfo]()

            var lastRequirement: Any.Type? = nil

            for (key, providerInfo) in providerStack {
                debugInfos.append(
                    ProviderRequestDebugInfo(
                        requestedType: key.ctype,
                        providerRequiredFor: lastRequirement,
                        sourceLocation: providerInfo.rawBinding.sourceLocation
                    )
                )

                lastRequirement = type(of: providerInfo.rawBinding.provider)
            }

            throw DependencyCycle(requirementStack: debugInfos)
        }

        providerStack.append((providerKey, providerInfo))
        precondition(!providersInStack.contains(providerInfo))
        providersInStack.insert(providerInfo)

        defer {
            _ = providerStack.popLast()
            providersInStack.remove(providerInfo)
        }

        for (key, d) in providerInfo.requirements.flatMap({ key in self.getProviderInfo(key).map { (key, $0) } }) {
            if key.ctype is AnyWeakProvider.Type {
                continue
            }


            try validateCycles(providerKey: key, providerInfo: d, providerStack: &providerStack, providersInStack: &providersInStack  )
        }
    }

    fileprivate func validate(requirement: ProviderKey, providerInfo:  ProviderInfo, errors: inout [CleanseError]) {
        #if SUPPORT_LEGACY_OBJECT_GRAPH
            if requirement == ProviderKey(Provider<LegacyObjectGraph>.self) {
                return
            }
        #endif

        guard doesHaveRequirement(requirement) else {
            errors.append(
                MissingProvider(requests: [
                    ProviderRequestDebugInfo(
                        requestedType: requirement.type,
                        providerRequiredFor:type(of: providerInfo.rawBinding.provider),
                        sourceLocation: providerInfo.rawBinding.sourceLocation
                    )]
                )
            )

            return
        }
    }

    fileprivate func getProviderInfo(_ key: ProviderKey) -> [ProviderInfo] {
        let key = providerAliases[key] ?? key

        var providers = getCurrentProviderInfo(key)

        var component = self.parentInfo

        while let c = component {
            providers += c.getCurrentProviderInfo(key)

            component = component?.parentInfo
        }

        return providers
    }


    fileprivate func getCurrentProviderInfo(_ key: ProviderKey) -> [ProviderInfo] {
        if let current = self.providers[key] , !current.isEmpty {
            return current
        }

        return maybeResolveCanonical(keyType: key.type)
    }

    fileprivate func doesHaveRequirement(_ key: ProviderKey) -> Bool {
        return !getProviderInfo(key).isEmpty
    }

    fileprivate func maybeResolveCanonical(keyType: Any.Type) -> [ProviderInfo] {
        if let keyType = keyType as? AnyProvider.Type {
            return maybeResolveCanonical(keyType: keyType.providesType)
        }

        guard let keyType = keyType as? AnyCanonicalRepresentable.Type else {
            return []
        }

        if let canonicalProviders = providers[ProviderKey(keyType.canonicalProviderType)] {
            return canonicalProviders
        }

        /// If we get here, check if we want to bind it

        return maybeResolveCanonical(keyType: keyType.canonicalProviderType)
    }
}


/// Verifies that all our dependencies are satisfied
final class ValidationVisitor : ComponentVisitor {
    var visitorState = VisitorState<ValidationVisitor>()

    fileprivate var rootComponent: ComponentInfo
    fileprivate var currentComponent: ComponentInfo

    fileprivate var components = [ComponentInfo]()

    fileprivate var currentProvider: ProviderInfo?

    init() {
        rootComponent = ComponentInfo(
            scope: nil,
            seed: Void.self,
            isRootComponent: true,
            parent: nil,
            componentType: nil
        )
        currentComponent = rootComponent
    }
    
    func enterComponent<C : Component>(dependency: C.Type) {
        enterComponentBase(isRoot: false, dependency: dependency)
    }

    func leaveComponent<C : Component>(dependency: C.Type) {
        leaveComponentBase()
    }

    func enterRootComponent<C : RootComponent>(dependency: C.Type) {
        enterComponentBase(isRoot: true, dependency: dependency)
    }

    func leaveRootComponent<C : RootComponent>(dependency: C.Type) {
        leaveComponentBase()
    }


    private func enterComponentBase<C : Cleanse.ComponentBase>(isRoot: Bool, dependency: C.Type) {
        let component = ComponentInfo(
            scope: C.Scope.scopeOrNil,
            seed: C.Seed.self,
            isRootComponent: isRoot,
            parent: currentComponent,
            componentType: dependency
        )

        components.append(component)

        currentComponent.subcomponentsInfo.append(component)
        currentComponent = component
    }

    private func leaveComponentBase() {
        currentComponent = currentComponent.parentInfo!
    }

    func enterProvider(binding: RawProviderBinding) {
        precondition(currentProvider == nil)
        currentProvider = ProviderInfo(rawBinding: binding)
    }

    
    func visitRequirement(requirement: AnyProvider.Type, binding: RawProviderBinding) {
        currentProvider!.requirements.insert(ProviderKey(requirement))
    }

    func leaveProvider(binding: RawProviderBinding) {
        let pkey = ProviderKey(type(of: binding.provider))
        
        if currentComponent.providers[pkey] == nil {
            currentComponent.providers[pkey] = [currentProvider!]
        } else {
            currentComponent.providers[pkey]!.append(currentProvider!)
        }

        currentComponent.providerAliases[ProviderKey(type(of: binding.provider).anyProviderToClosureType)] = pkey

        self.currentProvider  = nil
    }

    func enterModule<M : Module>(module: M.Type) {
    }

    func leaveModule<M : Module>(module: M.Type) {
    }

    func finalize(_ serviceLoader: CleanseServiceLoader) throws {
        let errorReporter = CleanseErrorReporter()
        var errors = [CleanseError]()

        for c in components {
            c.validate(&errors)
        }
        
        errorReporter.append(contentsOf: errors)
        
        for service in serviceLoader.services {
            service.visit(root: rootComponent, errorReporter: errorReporter)
        }
        
        try errorReporter.report()
    }
}
