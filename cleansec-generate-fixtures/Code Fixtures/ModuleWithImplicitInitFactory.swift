//
//  ModuleWithImplicitInitFactory.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct A {
    let string: String
    let number: Int
}

struct CoreAppModule3 : Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder
            .bind(A.self)
            .to(factory: A.init)
    }
}
