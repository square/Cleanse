//
//  Impl.swift
//  ArgumentParser
//
//  Created by Sebastian Edward Shanus on 3/24/20.
//

import Foundation


protocol Module {}

protocol Scope {
    func instance<E>(_ element: E) -> E
}

protocol ComponentBase {}

protocol Component: ComponentBase {
    associatedtype Root
    
    static var modules: [Module.Type] { get }
    static var parent: ComponentBase.Type? { get }
}

extension Component {
    static var parent: ComponentBase.Type? {
        return nil
    }
}

