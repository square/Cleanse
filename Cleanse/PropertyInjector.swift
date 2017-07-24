//
//  PropertyInjector.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/29/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public protocol PropertyInjectorProtocol  {
    associatedtype Element: AnyObject
    func injectProperties(into instance: Element)
}


/// This the mechanism property injection is done underneath the hood
public struct PropertyInjector<Element: AnyObject> : PropertyInjectorProtocol {
    let injectionClosure: (Element) -> Void
    
    /// Call this to inject properties into an instance of an object.
    public func injectProperties(into instance: Element) {
        injectionClosure(instance)
    }
}


#if SUPPORT_LEGACY_OBJECT_GRAPH
    
    /// This is used to for legacy support
    protocol AnyPropertyInjectorProtocol {
        func untypedInjectProperties(into instance: AnyObject)
        
        static var injectedType: AnyClass { get }
    }
    
    
    
    extension PropertyInjectorProtocol {
        func untypedInjectProperties(into instance: AnyObject) {
            injectProperties(into: instance as! Element)
        }
        
        static var injectedType: AnyClass {
            return Element.self
        }
    }
    
    extension PropertyInjector : AnyPropertyInjectorProtocol {
        
    }
#endif
