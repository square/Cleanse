//
//  LinkedModule.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/// `Cleanse.Module` representation with all standard providers and linked reference providers.
public struct LinkedModule {
    public let type: String
    public let providers: [StandardProvider]
    public let includedModules: [String]
    public let subcomponents: [String]
}
