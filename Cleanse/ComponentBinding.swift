//
//  ComponentBinding.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 10/11/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

/// Describes the object graph for a component node.
public protocol ComponentBinding {
    var scope: Scope.Type? { get }
    var seed: Any.Type { get }
    var parent: ComponentBinding? { get }
    var subcomponents: [ComponentBinding] { get }
    var componentType: Any.Type? { get }
    
    var providers: [ProviderKey: [ProviderInfo]] { get }
}
