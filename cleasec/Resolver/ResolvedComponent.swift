//
//  ResolvedComponent.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/24/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public class ResolvedComponent {
    public let type: String
    public weak var parent: ResolvedComponent?
    public var children: [ResolvedComponent]
    public let providersByType: [String:[CanonicalProvider]]
    public var diagnostics: [ResolutionError]
    
    public init(type: String, parent: ResolvedComponent?, providersByType: [String:[CanonicalProvider]], children: [ResolvedComponent] = [], diagnostics: [ResolutionError]) {
        self.type = type
        self.parent = parent
        self.children = children
        self.providersByType = providersByType
        self.diagnostics = diagnostics
    }
}
