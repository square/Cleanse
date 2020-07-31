//
//  ResolvedComponent.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

public final class ResolvedComponent {
    public let type: String
    public weak var parent: ResolvedComponent?
    public var children: [ResolvedComponent]
    public let providersByType: [TypeKey:[CanonicalProvider]]
    public let diagnostics: [ResolutionError]
    
    public init(type: String, providersByType: [TypeKey:[CanonicalProvider]], children: [ResolvedComponent], parent: ResolvedComponent? = nil, diagnostics: [ResolutionError] = []) {
        self.type = type
        self.providersByType = providersByType
        self.children = children
        self.parent = parent
        self.diagnostics = diagnostics
    }
}

extension ResolvedComponent: CustomStringConvertible {
    public var description: String {
        "COMPONENT: \(type) \n" + "BINDINGS:\n\(providersByType)\n" + "CHILDREN:\n" + "\(children)"
    }
}
