//
//  PluginRunner.swift
//  cleansec
//
//  Created by Sebastian Edward Shanus on 5/21/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import CleansecFramework

struct PluginRunner {
    static func run(plugin path: String, astFiles: [String]) -> [ModuleRepresentation] {
        astFiles.compactMap { Cleansec.run(plugin: path, astFilePath: $0) }
    }
}
