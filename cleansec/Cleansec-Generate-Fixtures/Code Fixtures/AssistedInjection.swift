//
//  AssistedInjection.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct AssistedObject {
    let assisted: Assisted<Int>
    let string: String
}

class AssistedSeed: AssistedFactory {
    typealias Seed = Int
    typealias Element = AssistedObject
}

struct AssistedModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.bindFactory(AssistedObject.self).with(AssistedSeed.self).to(factory: AssistedObject.init)
    }
}
