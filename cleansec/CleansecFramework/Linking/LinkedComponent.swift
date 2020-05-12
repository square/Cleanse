//
//  LinkedComponent.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/// `Cleanse.Component` representation with all linked providers.
public struct LinkedComponent {
    public let type: String
    public let rootType: String
    public let providers: [StandardProvider]
    public let seed: String
    public let includedModules: [String]
    public let subcomponents: [String]
    public let isRoot: Bool
}
