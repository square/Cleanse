//
//  ComponentVisitor.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

class VisitorState<V: ComponentVisitor> {
    fileprivate var enqueuedRequirementFutures = [AnyProvider.Type]()
    /// These are for errors that make it impossible to traverse the module hierarchy

    init() {
    }
}

protocol ComponentVisitor : class, BinderBase {
    /// Used to track state for binder
    var visitorState: VisitorState<Self> { get set }
    
    /// Have to implement this to have a return value for a provider. Default implementation explodes
    func resolveProvider<Element>(type: Element.Type, requiredBy: Any.Type?) -> Provider<Element>
    
    func enterModule<M: Module>(module: M.Type)
    func leaveModule<M: Module>(module: M.Type)

    func enterComponent<C: Component>(dependency: C.Type)
    func leaveComponent<C: Component>(dependency: C.Type)

    func enterRootComponent<C: RootComponent>(dependency: C.Type)
    func leaveRootComponent<C: RootComponent>(dependency: C.Type)


    func enterProvider(binding: RawProviderBinding)
    func leaveProvider(binding: RawProviderBinding)
    
    func visitRequirement(requirement: AnyProvider.Type, binding: RawProviderBinding)
}

protocol SimpleComponentVisitor : ComponentVisitor {

}

extension SimpleComponentVisitor {
    func enterModule<M : Module>(module: M.Type) {
    }
    
    func leaveModule<M : Module>(module: M.Type) {
    }
    
    func enterProvider(binding: RawProviderBinding) {
    }
    
    func leaveProvider(binding: RawProviderBinding) {
    }

    func enterComponent<C: Component>(dependency: C.Type) {
    }

    func leaveComponent<C: Component>(dependency: C.Type) {
    }

    func enterRootComponent<C: RootComponent>(dependency: C.Type) {
    }

    func leaveRootComponent<C: RootComponent>(dependency: C.Type) {
    }

    func visitRequirement(requirement: AnyProvider.Type, binding: RawProviderBinding) {
    }
}

extension ComponentVisitor {
     func _internalBind(binding: RawProviderBinding) {
        enterProvider(binding: binding)
        
        let requirements = visitorState.enqueuedRequirementFutures
        visitorState.enqueuedRequirementFutures.removeAll()
        
        for requirement in requirements {
            visitRequirement(requirement: requirement, binding: binding)
        }
        
        leaveProvider(binding: binding)
    }

    
    func include<M : Module>(module: M.Type) {
        enterModule(module: module)
        module.configure(binder: .init(binder: self))
        leaveModule(module: module)
    }

    private func install<C : Cleanse.ComponentBase>(componentBase dependency: C.Type) {
        // If the seed isn't void
        if C.Seed.self != Void.self {
            if let seed = C.Seed.self as? AnyProvider.Type {
                _internalBind(binding: RawProviderBinding(
                    scope: nil,
                    provider: seed.makeNew { preconditionFailure(); _ = Void() },
                    collectionMergeFunc:  nil,
                    sourceLocation: nil
                ))
            } else {
                _internalBind(binding: RawProviderBinding(
                    scope: nil,
                    provider: Provider<C.Seed> { preconditionFailure(); _ = Void() },
                    collectionMergeFunc:  nil,
                    sourceLocation: nil
                ))
            }

        }

        dependency.configure(binder: .init(binder: self))
        self.bind(C.Root.self).configured(with: C.configureRoot)

    }

    private func bindFactory<C : Cleanse.ComponentBase>(_ dependency: C.Type) {
        self.bind(ComponentFactory<C>.self).to { () -> ComponentFactory<C> in
            preconditionFailure("Should not ever evaluate"); _ = Void()
        }
    }

    func install<C : Component>(dependency: C.Type) {
        bindFactory(C.self)
        enterComponent(dependency: dependency)
        self.install(componentBase: dependency)
        leaveComponent(dependency: dependency)
    }

    func install<C : RootComponent>(dependency: C.Type) {
        bindFactory(C.self)
        enterRootComponent(dependency: dependency)
        self.install(componentBase: dependency)
        leaveRootComponent(dependency: dependency)
    }

    func _internalProvider<Element>(_ type: Element.Type, debugInfo: ProviderRequestDebugInfo?) -> Provider<Element> {
        if let type = type as? AnyProvider.Type {
            visitorState.enqueuedRequirementFutures.append(type)
        } else {
            visitorState.enqueuedRequirementFutures.append(Provider<Element>.self)
        }

        return resolveProvider(type: Element.self, requiredBy: debugInfo?.providerRequiredFor)
    }
    
    func resolveProvider<Element>(type: Element.Type, requiredBy: Any.Type?) -> Provider<Element> {
        return Provider {
            preconditionFailure("Cannot call synthesized provider. Invalid requested type: \(Element.self). Depended on by \(requiredBy!)"); _ = ()
        }
    }
}
