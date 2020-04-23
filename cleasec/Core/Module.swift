//
//  Module.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct Module: CustomStringConvertible {
    public let type: String
    public let providers: [Provider]
    public let danglingProviders: [DanglingProvider]
    public let referenceProviders: [ReferenceProvider]
    public let includedModules: [String]
    public let subcomponents: [String]
    
    public var description: String {
        "Module:\(type)\n  \(providers)\n  \(danglingProviders)\n  \(referenceProviders)\n--\nincludedModules:\(includedModules)\nsubcomponets:\(subcomponents)"
    }
}
