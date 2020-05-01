//
//  CollectionBindings.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct Singular {
    let a: Array<Int>
}

struct CollectionModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.bind(Singular.self).to { (a:Array<Int>) -> Singular in
            return Singular(a: a)
        }
        
        binder.bind(Singular.self).to { (a: [ [Int] ]) in
            return Singular(a: a.first!)
        }
        
        binder
            .bind(Int.self)
            .intoCollection()
            .to(value: 5)
        
        binder
            .bind(Int.self)
            .intoCollection()
            .to(value: [1,2,3])
        
        binder
            .bind([Int].self)
            .intoCollection()
            .to(value: [2])
    }
}
