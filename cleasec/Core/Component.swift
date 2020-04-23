//
//  Component.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct ModuleOutput {
    public let modules: [Module]
    public let components: [Component]
}

public struct Component {
    public let type: String
    public let rootType: String
    public let providers: [StandardProvider]
    public let danglingProviders: [DanglingProvider]
    public let referenceProviders: [ReferenceProvider]
    public let seed: String
    public let modules: [String]
    public let subcomponents: [String]
    public let isRoot: Bool
}
