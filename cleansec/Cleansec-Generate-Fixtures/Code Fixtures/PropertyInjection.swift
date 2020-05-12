//
//  PropertyInjection.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

class PropertyClass {
}

struct PropertyInjectionModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bindPropertyInjectionOf(PropertyClass.self)
            .to { (a: PropertyClass, number: Int) in
        }
    }
}
