//
//  LegacyObjectGraph.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/27/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

#if SUPPORT_LEGACY_OBJECT_GRAPH

typealias LegacyProviderProvider = (AnyClass, String?) -> ()-> AnyObject
typealias LegacyPropertyInjectorProvider = (AnyClass) -> (AnyObject) -> Void

/// Protocol with base method for LegacyObjectGraph
public protocol LegacyObjectGraphProtocol {
    
    /// Core method that all legacy methods are based off of. This returns a function that when evaluated it will emit the instance registered for `cls`
    func providerForClass(cls: AnyClass, withName name: String?) -> ()-> AnyObject
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
    @objc(objectForClass:) public func objectForClass(cls: AnyClass) -> AnyObject {
        return objectForClass(cls: cls, withName: nil)
    }
    
    /// Convenience method equivalent to `providerForClass(cls: cls, withName: nil)`
    @objc(providerForClass:) public func providerForClass(cls: AnyClass) -> ()-> AnyObject {
        return providerForClass(cls: cls, withName: nil)
    }
    
    /// Convenience method equivalent to `providerForClass(cls: cls, withName: name)()`
    @objc(objectForClass:withName:) public func objectForClass(cls: AnyClass, withName name: String?) -> AnyObject {
        return providerForClass(cls: cls, withName: name)()
    }
    
    @objc public func providerForClass(cls: AnyClass, withName name: String?) -> ()-> AnyObject {
        return graph.legacyProvider(cls: cls, name:  name).get
    }
    
    /// Injects properties into an injectable class marked with ST_INJECT(). These properties must be declared in the base interface
    @objc(injectPropertiesIntoObject:) public func injectPropertiesIntoObject(object: AnyObject) {
        graph.legacyPropertyInjector(cls: type(of: object))(object)
    }
}

extension _AnyTag {
    /// This is a hack to be compatible with legacy names
    static var legacyName: String? {
        return "\(self)".components(separatedBy: ".").suffix(from: 0).joined(separator: ".")
    }
}


/// LegacyObjectGraphs just appear, so we can have a default implementation
public extension ComponentBase where Root == LegacyObjectGraph {
    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return BindingReceipt()
    }
}

#endif
