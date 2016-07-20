//
//  SatisfiedDependenciesValidationVisitor.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/19/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


extension ProviderProtocol {
    private static var providerToClosureType: Provider<() -> Element>.Type {
        return Provider<() -> Element>.self
    }
}

extension AnyProvider where Self: ProviderProtocol {
    static var anyProviderToClosureType: AnyProvider.Type {
        return providerToClosureType
    }
}

private struct ComponentKey : TypeKeyProtocol {
    let ctype: _AnyBaseComponent.Type

    var type: Any.Type {
        return ctype
    }

    init<C: Component>(_ type: C.Type) {
        self.ctype = type
    }
}

private struct ProviderKey : TypeKeyProtocol {
    let ctype: AnyProvider.Type

    var type: Any.Type {
        return ctype
    }

    init(_ type: AnyProvider.Type) {
        self.ctype = type as! AnyProvider.Type
    }
}

private struct ProviderInfo {
    let rawBinding: RawProviderBinding
    var requirements: Set<ProviderKey> = []
}

private class ComponentInfo {
    let scope: Scope.Type?
    let seed: Any.Type
    let isRootComponent: Bool

    weak var parent: ComponentInfo?

    var subcomponents: [ComponentInfo] = []

    var providers = [ProviderKey: [ProviderInfo]]()

    var providerAliases = [ProviderKey: ProviderKey]()

    init(scope: Scope.Type?, seed: Any.Type, isRootComponent: Bool, parent: ComponentInfo?) {
        self.isRootComponent = isRootComponent
        self.scope = scope
        self.seed = seed
        self.parent = parent
    }

    private func validate(inout errors: [CleanseError]) {
        for p in providers.values.flatten() {
            validate(provider: p, errors: &errors)
        }
    }

    private func validate(provider provider:  ProviderInfo, inout errors: [CleanseError]) {
        for r in provider.requirements {
            validate(requirement: r, provider: provider, errors: &errors)
        }
    }
    
    private func validate(requirement requirement: ProviderKey, provider:  ProviderInfo, inout errors: [CleanseError]) {
        if !doesHaveRequirement(requirement) {

            errors.append(
                MissingProvider(requests: [
                    ProviderRequestDebugInfo(
                        requestedType: requirement.type,
                        providerRequiredFor:provider.rawBinding.provider.dynamicType,
                        sourceLocation: provider.rawBinding.sourceLocation
                    )
                    ]
                ))
        }
    }

    private func getProviderInfo(key: ProviderKey) -> [ProviderInfo] {
        let key = providerAliases[key] ?? key

        var providers = getCurrentProviderInfo(key)

        var component = self.parent

        while let c = component {
            providers += c.getCurrentProviderInfo(key)

            component = component?.parent
        }

        return providers
    }


    private func getCurrentProviderInfo(key: ProviderKey) -> [ProviderInfo] {
        let keyType = key.type
        let providerKey: ProviderKey

        if let current = self.providers[key] where !current.isEmpty {
            return current
        }

        return maybeResolveCanonical(keyType: key.type)
    }

    private func doesHaveRequirement(key: ProviderKey) -> Bool {
        return !getProviderInfo(key).isEmpty
    }


    private func maybeResolveCanonical(keyType keyType: Any.Type) -> [ProviderInfo] {
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
final class SatisfiedDependenciesValidationVisitor : ComponentVisitor {
    var visitorState = VisitorState<SatisfiedDependenciesValidationVisitor>()

    private var rootComponent: ComponentInfo
    private var currentComponent: ComponentInfo

    private var components = [ComponentInfo]()

    private var currentProvider: ProviderInfo?

    init() {
        rootComponent = ComponentInfo(scope: nil, seed: Void.self, isRootComponent: true, parent: nil)
        currentComponent = rootComponent
    }
    func enterComponent<C : Component>(dependency dependency: C.Type) {
        let component = ComponentInfo(scope: C.Scope.scopeOrNil, seed: C.Seed.self, isRootComponent: C.isRootComponent, parent: currentComponent)

        components.append(component)

        currentComponent.subcomponents.append(component)
        currentComponent = component
    }

    func leaveComponent<C : Component>(dependency dependency: C.Type) {
        currentComponent = currentComponent.parent!
    }


    func enterProvider(binding binding: RawProviderBinding) {
        precondition(currentProvider == nil)
        currentProvider = ProviderInfo(rawBinding: binding, requirements: [])
    }

    
    func visitRequirement(requirement requirement: AnyProvider.Type, binding: RawProviderBinding) {
        currentProvider!.requirements.insert(ProviderKey(requirement))
    }

    func leaveProvider(binding binding: RawProviderBinding) {
        let pkey = ProviderKey(binding.provider.dynamicType)
        
        if currentComponent.providers[pkey] == nil {
            currentComponent.providers[pkey] = [currentProvider!]
        } else {
            currentComponent.providers[pkey]!.append(currentProvider!)
        }

        currentComponent.providerAliases[ProviderKey(binding.provider.dynamicType.anyProviderToClosureType)] = pkey

        self.currentProvider  = nil
    }

    public func finalize() throws {
        var errors = [CleanseError]()

        for c in components {
            c.validate(&errors)
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
    }
}
