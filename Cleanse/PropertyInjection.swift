//
//  PropertyInjection.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/26/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// We only allow property injection for objects. It is less preferred than constructor injection,
/// but it is required to interface with storyboard-created objects as well as XCTestCases.
/// It depends on the objective-c runtime and should be considered supplementary at best
extension BinderBase {
    /// First step in creating a property injector.
    public func bindPropertyInjectionOf<Element: AnyObject>(_ class: Element.Type=Element.self) -> PropertyInjectorBindingBuilder<Self, Element> {
        return PropertyInjectorBindingBuilder(binder: self)
    }
}

/// Protocol used for `PropertyInjectorBindingBuilder`.
/// This is used to be able to have extensions on `PropertyInjectorBindingBuilder` using type constraints
public protocol PropertyInjectorBindingBuilderProtocol {
    /// The Binder type that the completed step will call `_internalBind()` on
    associatedtype B: BinderBase
    
    /// Element type that the property injection will be performed on
    associatedtype Element: AnyObject
    
    /// Converts back to `PropertyInjectorBindingBuilder`. Since `PropertyInjectorBindingBuilder` is the only implementation of this protocol, it just returns self
    func toPropertyInjectorBindingBuilder() -> PropertyInjectorBindingBuilder<B, Element>
}

extension PropertyInjectorBindingBuilderProtocol {
    var binder: B {
        return toPropertyInjectorBindingBuilder().binder
    }
}

/// This is the builder used to bind a property injection. This is constructed by calling `Binder.bindPropertyInjectionOf`
public struct PropertyInjectorBindingBuilder<B: BinderBase, Element: AnyObject> : PropertyInjectorBindingBuilderProtocol {
    fileprivate let binder: B
    
    init(binder: B) {
        self.binder = binder
    }
    
    public func toPropertyInjectorBindingBuilder() -> PropertyInjectorBindingBuilder<B, Element> {
        return self
    }
}


extension PropertyInjectorBindingBuilderProtocol {
    /// This is where the injection happens    
    func innerTo(propertyInjector: @escaping (Element) -> Void,
                 file: StaticString,
                 line: Int,
                 function: StaticString) -> BindingReceipt<PropertyInjector<Element>> {
        
        let realBuilder = toPropertyInjectorBindingBuilder()
        let binder = realBuilder.binder
        
        typealias Injector = (Element) -> Void
        
        return binder
            .bind()
            .to(value: PropertyInjector(injectionClosure: propertyInjector), file: file, line: line, function: function)
    }
}
