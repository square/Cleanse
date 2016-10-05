//
//  ComponentVisitor.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

class VisitorState<V: ComponentVisitor> {
    private var enqueuedRequirementFutures = [AnyProvider.Type]()
    /// These are for errors that make it impossible to traverse the module hierarchy

    init() {
    }
}

protocol ComponentVisitor : Binder {
    /// Used to track state for binder
    var visitorState: VisitorState<Self> { get set }
    
    /// Have to implement this to have a return value for a provider. Default implementation explodes
    func resolveProvider<Element>(_ type: Element.Type, requiredBy: Any.Type?) -> Provider<Element>
    
    func enterModule<M: Module>(module module: M.Type)
    func leaveModule<M: Module>(module module: M.Type)

    func enterComponent<C: Component>(dependency dependency: C.Type)
    func leaveComponent<C: Component>(dependency dependency: C.Type)

    func enterProvider(binding binding: RawProviderBinding)
    func leaveProvider(binding binding: RawProviderBinding)
    
    func visitRequirement(requirement requirement: AnyProvider.Type, binding: RawProviderBinding)
}

extension ComponentVisitor {
    func enterModule<M : Module>(module module: M.Type) {
    }
    
    func leaveModule<M : Module>(module module: M.Type) {
    }
    
    func enterProvider(binding binding: RawProviderBinding) {
    }
    
    func leaveProvider(binding binding: RawProviderBinding) {
    }

    func enterComponent<C: Component>(dependency dependency: C.Type) {
    }

    func leaveComponent<C: Component>(dependency dependency: C.Type) {
    }

    func visitRequirement(requirement requirement: AnyProvider.Type, binding: RawProviderBinding) {
    }
}

extension ComponentVisitor {
     func _internalBind(binding binding: RawProviderBinding) {
        enterProvider(binding: binding)
        
        let requirements = visitorState.enqueuedRequirementFutures
        visitorState.enqueuedRequirementFutures.removeAll()
        
        for requirement in requirements {
            visitRequirement(requirement: requirement, binding: binding)
        }
        
        leaveProvider(binding: binding)
    }

    
    func install<M : Module>(module module: M.Type) {
        enterModule(module: module)
        module.configure(binder: self)
        leaveModule(module: module)
    }

    func install<C : Cleanse.Component>(dependency dependency: C.Type) {
        bind(ComponentFactory<C>.self).to { () -> ComponentFactory<C> in
            preconditionFailure("Should not ever evaluate"); _ = Void()
        }

        enterComponent(dependency: dependency)

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

        dependency.configure(binder: self)
        leaveComponent(dependency: dependency)
    }

    func _internalProvider<Element>(_ type: Element.Type, debugInfo: ProviderRequestDebugInfo?) -> Provider<Element> {
        if let type = type as? AnyProvider.Type {
            visitorState.enqueuedRequirementFutures.append(type)
        } else {
            visitorState.enqueuedRequirementFutures.append(Provider<Element>.self)
        }

        return resolveProvider(Element.self, requiredBy: debugInfo?.providerRequiredFor)
    }
    
    func resolveProvider<Element>(_ type: Element.Type, requiredBy: Any.Type?) -> Provider<Element> {
        return Provider {
            preconditionFailure("Cannot call synthesized provider. Invalid requested type: \(Element.self). Depended on by \(requiredBy!)"); _ = ()
        }
    }
}
