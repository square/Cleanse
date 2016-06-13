//
//  ComponentVisitor.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

class VisitorState<V: ComponentVisitor> {
    private var enqueuedRequirementFutures = [Any.Type]()
    /// These are for errors that make it impossible to traverse the module hierarchy
    private var accumulatedErrors  = [CleanseError]()
    
    private var inOverridesMode = false
    
    private var proxyObjectProviders = Dictionary<ProxyTypeKey, AnyProvider>()
    
    init() {
    }
    
    private func appendError<Element: CleanseError>(error error: Element) {
        self.accumulatedErrors.append(error)
    }
}

private struct ProxyTypeKey : TypeKeyProtocol {
    let type: Any.Type
    
    init(_ type: Any.Type) {
        self.type = type
    }
}

extension VisitorState : ProxyFactory {
    func _internalProxyOf<O>(_ type: O.Type) -> O {
        
        
        if let existingProvider = proxyObjectProviders[ProxyTypeKey(type)] {
            return existingProvider.asCheckedProvider(O.self).get()
        }
        
        precondition(type is AnyProxyFactoryInitializable.Type, "Requested proxy object for \(type) which it is not convertable to")
        return (type as! AnyProxyFactoryInitializable.Type).makeAnyProxyObject(proxyFactory: self) as! O
    }
}

protocol ComponentVisitor : Binder {
    /// Used to track state for binder
    var visitorState: VisitorState<Self> { get set }
    
    /// Have to implement this to have a return value for a provider. Default implementation explodes
    func resolveProvider<Element>(_ type: Element.Type, requiredBy: Any.Type?) -> Provider<Element>
    
    func enterComponent<C: _AnyComponent>(component component: C, _internalRootType: Any.Type)
    func leaveComponent<C: _AnyComponent>(component component: C, _internalRootType: Any.Type)
    

    func enterModule<M: Module>(module module: M)
    func leaveModule<M: Module>(module module: M)
    
    func enterProvider(binding binding: RawProviderBinding)
    func leaveProvider(binding binding: RawProviderBinding)
    
    func visitRequirement(requirement requirement: Any.Type, binding: RawProviderBinding)
}

extension ComponentVisitor {
    func enterComponent<C : _AnyComponent>(component component: C, _internalRootType: Any.Type) {
    }
    
    func leaveComponent<C : _AnyComponent>(component component: C, _internalRootType: Any.Type) {
    }
    
    func enterModule<M : Module>(module module: M) {
    }
    
    func leaveModule<M : Module>(module module: M) {
    }
    
    func enterProvider(binding binding: RawProviderBinding) {
    }
    
    func leaveProvider(binding binding: RawProviderBinding) {
    }
    
    func visitRequirement(requirement requirement: Any.Type, binding: RawProviderBinding) {
    }
}

extension _AnyComponent {
    private func doComponentVisit<V: ComponentVisitor>(visitor visitor: V) {
        visitor.enterComponent(component: self, _internalRootType: Self._internalRootType)
        visitor.install(module: self)
        visitor.leaveComponent(component: self, _internalRootType: Self._internalRootType)
    }
}

extension ComponentVisitor {
     func _internalBind(binding binding: RawProviderBinding) {
        enterProvider(binding: binding)
        
        let requirements = visitorState.enqueuedRequirementFutures
        defer { visitorState.enqueuedRequirementFutures.removeAll() }
        
        for requirement in requirements {
            visitRequirement(requirement: requirement, binding: binding)
        }
        
        maybeBindComponent(binding: binding, requirements: requirements)
        
        leaveProvider(binding: binding)
    }
    
    /// We want to detect if what's being bound is a component. If so, intercept it and possibly instantiate it.
    private func maybeBindComponent(binding binding: RawProviderBinding, requirements: [Any.Type]) {
        if let componentProvider = binding.componentOrSubcomponentProvider, component = componentProvider.instanceProvidesType as? _AnyComponent.Type {
            for r in requirements {
                if let r = r as? AnyProxyFactoryInitializable.Type where r.isActuallyProxyObject {
                    
                } else {
                    precondition(visitorState.proxyObjectProviders[ProxyTypeKey(r)] != nil, "Must have already visitied the provider for the proxy object requested \(ProxyTypeKey(r)) needed by \(component)")
                }
            }
            
            // We instantiate a component for validation

            if visitorState.proxyObjectProviders[ProxyTypeKey(component)] == nil {
                visitorState.proxyObjectProviders[ProxyTypeKey(component)] = componentProvider
            }
            
            let tempComponent = componentProvider.getAny() as! _AnyComponent

            tempComponent.doComponentVisit(visitor: self)
        }
    }
    
    func install<M : Module>(module module: M) {
        enterModule(module: module)
        module.configure(binder: self)
        leaveModule(module: module)
    }
    
    func _internalProvider<Element>(_ type: Element.Type, debugInfo: ProviderRequestDebugInfo?) -> Provider<Element> {
        visitorState.enqueuedRequirementFutures.append(Element.self)
        
        return resolveProvider(Element.self, requiredBy: debugInfo?.providerRequiredFor)
    }
    
    func resolveProvider<Element>(_ type: Element.Type, requiredBy: Any.Type?) -> Provider<Element> {
        if let existingProxy = visitorState.proxyObjectProviders[ProxyTypeKey(type)]?.asCheckedProvider(type) {
            return existingProxy
        }
        
        if type is AnyProxyFactoryInitializable.Type {
            return Provider<Element>.makeProxyObject(proxyFactory: self.visitorState)
        }
        
        return Provider {
            preconditionFailure("Cannot call synthesized provider. Invalid requested type: \(Element.self). Depended on by \(requiredBy!)"); _ = ()
        }
    }
    
    func _internalWithOverrides(@noescape closure closure: () -> ()) {
        let oldModeMode = visitorState.inOverridesMode
        defer { visitorState.inOverridesMode = oldModeMode }
        
        visitorState.inOverridesMode = true
        
        closure()
    }
}
