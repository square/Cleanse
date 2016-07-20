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
        self.ctype = type
    }
}

private class ProviderInfo : DelegatedHashable, CustomStringConvertible {
    let rawBinding: RawProviderBinding
    var requirements: Set<ProviderKey> = []

    init(rawBinding: RawProviderBinding) {
        self.rawBinding = rawBinding
    }

    var hashable: ObjectIdentifier {
        return ObjectIdentifier(self)
    }

    private var description: String {
        return "ProviderInfo for \(rawBinding.provider.dynamicType)"
    }
}

private class ComponentInfo {
    let scope: Scope.Type?
    let seed: Any.Type
    let isRootComponent: Bool

    weak var parent: ComponentInfo?

    var subcomponents: [ComponentInfo] = []

    var providers = [ProviderKey: [ProviderInfo]]()

    var providerAliases = [ProviderKey: ProviderKey]()

    private var cycleCheckedProviders = Set<ProviderInfo>()

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

    private func validate(provider providerInfo:  ProviderInfo, inout errors: [CleanseError]) {
        for r in providerInfo.requirements {
            validate(requirement: r, providerInfo: providerInfo, errors: &errors)
        }

        do {
            try validateCycles(providerKey: ProviderKey(providerInfo.rawBinding.provider.dynamicType), providerInfo: providerInfo)
        } catch let e as CleanseError {
            errors.append(e)
        } catch {
            preconditionFailure("Unexpected Error")
        }
    }

    // Once we find one cycle, stop (hence throwing instead of appending to a list of errors)
    private func validateCycles(providerKey providerKey: ProviderKey, providerInfo:  ProviderInfo) throws {

        var providerStack = [(ProviderKey, ProviderInfo)]()
        var providersInStack = Set<ProviderInfo>()

        try self.validateCycles(
            providerKey: providerKey,
            providerInfo: providerInfo,
            providerStack: &providerStack,
            providersInStack: &providersInStack
        )
    }

    private func validateCycles(providerKey providerKey: ProviderKey, providerInfo:  ProviderInfo, inout providerStack: [(ProviderKey, ProviderInfo)], inout providersInStack: Set<ProviderInfo>) throws {
        if cycleCheckedProviders.contains(providerInfo) {
            return
        }

        defer {
            cycleCheckedProviders.insert(providerInfo)
        }

        guard !providersInStack.contains(providerInfo) else {
            let providerStack = providerStack.suffixFrom(providerStack.indexOf { $1 == providerInfo }!) + [(providerKey, providerInfo)]

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

                lastRequirement = providerInfo.rawBinding.provider.dynamicType
            }

            throw DependencyCycle(requirementStack: debugInfos)
        }

        providerStack.append((providerKey, providerInfo))
        precondition(!providersInStack.contains(providerInfo))
        providersInStack.insert(providerInfo)

        defer {
            providerStack.popLast()
            providersInStack.remove(providerInfo)
        }

        for (key, d) in providerInfo.requirements.flatMap({ key in self.getProviderInfo(key).map { (key, $0) } }) {
            if key.ctype is AnyWeakProvider.Type {
                continue
            }


            try validateCycles(providerKey: key, providerInfo: d, providerStack: &providerStack, providersInStack: &providersInStack  )
        }
    }

    private func validate(requirement requirement: ProviderKey, providerInfo:  ProviderInfo, inout errors: [CleanseError]) {
        guard doesHaveRequirement(requirement) else {

            errors.append(
                MissingProvider(requests: [
                    ProviderRequestDebugInfo(
                        requestedType: requirement.type,
                        providerRequiredFor:providerInfo.rawBinding.provider.dynamicType,
                        sourceLocation: providerInfo.rawBinding.sourceLocation
                    )]
                )
            )

            return
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
        currentProvider = ProviderInfo(rawBinding: binding)
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
