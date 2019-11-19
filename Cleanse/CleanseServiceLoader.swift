//
//  CleanseServiceLoader.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 10/10/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

/// Service loader for binding plugins. Passed into `RootComponent` factory function.
public final class CleanseServiceLoader {
    var services: [CleanseBindingPlugin]
    public init(_ services: [CleanseBindingPlugin] = []) {
        self.services = services
    }
    
    public func register(_ plugin: CleanseBindingPlugin) {
        services.append(plugin)
    }
    
    public static var instance: CleanseServiceLoader {
        return CleanseServiceLoader()
    }
}
