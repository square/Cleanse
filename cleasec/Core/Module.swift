//
//  Module.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct Module {
    public let type: String
    public let providers: [Provider]
    public let includedModules: [String]
    public let subcomponents: [String]
}
