//
//  DebugData.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/26/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

public struct DebugData: Equatable, Codable {
    public let location: String?
    
    public static var empty = DebugData(location: nil)
    
    public static func location(_ loc: String) -> DebugData {
        DebugData(location: loc)
    }
}
