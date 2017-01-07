//
//  LegacyObjectGraph.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/27/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

#if SUPPORT_LEGACY_OBJECT_GRAPH

typealias LegacyProviderProvider = (AnyClass, String?) -> () -> AnyObject
typealias LegacyPropertyInjectorProvider = AnyClass -> AnyObject -> ()

/// Protocol with base method for LegacyObjectGraph
public protocol LegacyObjectGraphProtocol {
    
    /// Core method that all legacy methods are based off of. This returns a function that when evaluated it will emit the instance registered for `cls`
    func providerForClass(cls: AnyClass, withName name: String?) -> () -> AnyObject
}

/// This is a class to support backwards compatibility for Cleanse's Predecessor, Stiletto.
/// It also is useful for being able to access an object graph interface from Objective-C
/// - Note: This interface should be considered experimental and subject to change and go away
@objc public class LegacyObjectGraph : NSObject, LegacyObjectGraphProtocol {
    private let graph: Graph
    
    init(graph: Graph) {
        self.graph = graph
    }
    
    /// Convenience method equivalent to `providerForClass(cls: cls, withName: nil)()`
    @objc public func objectForClass(cls: AnyClass) -> AnyObject {
        #if swift(>=3.0)
            return objectForClass(cls: cls, withName: nil)
        #else
            return objectForClass(cls, withName: nil)
        #endif

    }
    
    /// Convenience method equivalent to `providerForClass(cls: cls, withName: nil)`
    @objc public func providerForClass(cls: AnyClass) -> () -> AnyObject {
        #if swift(>=3.0)
            return providerForClass(cls: cls, withName: nil)
        #else
            return providerForClass(cls, withName: nil)
        #endif
    }
    
    /// Convenience method equivalent to `providerForClass(cls: cls, withName: name)()`
    @objc public func objectForClass(cls: AnyClass, withName name: String?) -> AnyObject {
        #if swift(>=3.0)
            return providerForClass(cls: cls, withName: name)()
        #else
            return providerForClass(cls, withName: name)()
        #endif
    }
    
    @objc public func providerForClass(cls: AnyClass, withName name: String?) -> () -> AnyObject {
        return graph.legacyProvider(cls: cls, name:  name).get
    }
    
    /// Injects properties into an injectable class marked with ST_INJECT(). These properties must be declared in the base interface
    @objc public func injectPropertiesIntoObject(object: AnyObject) {
        graph.legacyPropertyInjector(cls: object.dynamicType)(object)
    }
}

extension _AnyTag {
    /// This is a hack to be compatible with legacy names
    static var legacyName: String? {
        #if swift(>=3.0)
            return "\(self)".components(separatedBy: ".").suffix(from: 0).joined(separator: ".")
        #else
            return "\(self)".componentsSeparatedByString(".").suffixFrom(0).joinWithSeparator(".")
        #endif
    }
}


/// LegacyObjectGraphs just appear, so we can have a default implementation
public extension Component where Root == LegacyObjectGraph {
    public static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return BindingReceipt()
    }
}

#endif
