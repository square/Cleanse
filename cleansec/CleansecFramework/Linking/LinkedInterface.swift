//
//  LinkedInterface.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/// Representation of all components and modules with their providers linked.
public struct LinkedInterface {
    public let components: [LinkedComponent]
    public let modules: [LinkedModule]
}
