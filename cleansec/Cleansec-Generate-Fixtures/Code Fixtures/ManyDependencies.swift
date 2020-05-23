//
//  ManyDependencies.swift
//  Cleansec-Generate-Fixtures
//
//  Created by Sebastian Edward Shanus on 5/23/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import Cleanse

struct BigLot {
    let one: Int
    let two: Int
    let three: Int
    let four: Int
    let five: Int
    let six: Int
    let seven: Int
    let eight: Int
    let nine: Int
    let ten: Int
}

fileprivate struct ManyDependenciesModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.bind(BigLot.self).to(factory: BigLot.init)
    }
    
    
}
