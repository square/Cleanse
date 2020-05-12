//
//  ModuleWithDependencies.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct CoreAppModule : Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder
        .bind(String.self)
        .to { (a: Int, b: Character, c: Float) -> String in
                return "\(a)\(b)\(c)"
        }
    }
}

struct CoreAppModule2 : Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder
        .bind(String.self)
        .to(value: "square")
    }
}
