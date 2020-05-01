//
//  ModuleIncludesModule.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct AnotherModule: Cleanse.Module {
    static func configure(binder: Binder<Unscoped>) {}
}

struct CoreAppModule5 : Cleanse.Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.include(module: AnotherModule.self)
    }
}
