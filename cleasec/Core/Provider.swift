//
//  Provider.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

struct Provider {
    let type: String
    let dependencies: [String]
    let tag: String?
    let scoped: String?
}
