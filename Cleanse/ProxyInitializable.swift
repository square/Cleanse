//
//  ProxyInitializable.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


protocol AnyProxyFactoryInitializable {
    static func makeAnyProxyObject<F: ProxyFactory>(proxyFactory proxyFactory: F) -> Any
    
    /// This is for types that may not actually be proxy objects, such as Tagged
    static var isActuallyProxyObject: Bool { get }
}


protocol ProxyFactoryInitializable : AnyProxyFactoryInitializable {
    static func makeProxyObject<F: ProxyFactory>(proxyFactory proxyFactory: F) -> Self
}

protocol ProxyFactory {
    func _internalProxyOf<O>(_ type: O.Type) -> O
}

extension ProxyFactory {
    func of<O>(_ type: O.Type=O.self) -> O {
        return _internalProxyOf(type)
    }
}

extension ProxyFactoryInitializable {
    static func makeAnyProxyObject<F: ProxyFactory>(proxyFactory proxyFactory: F) -> Any {
        return makeProxyObject(proxyFactory: proxyFactory)
    }
}
