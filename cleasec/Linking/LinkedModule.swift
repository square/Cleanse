//
//  LinkedModule.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/24/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct LinkedModule {
    public let type: String
    public let providers: [StandardProvider]
    public let includedModules: [String]
    public let subcomponents: [String]
}
