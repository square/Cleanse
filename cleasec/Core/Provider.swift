//
//  Provider.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct Provider {
    public let type: String
    public let dependencies: [String]
    public let tag: String?
    public let scoped: String?
}
