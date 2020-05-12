//
//  GenericType.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/4/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

fileprivate struct GenericType<A> {
    let dependencyA: A
}

fileprivate struct GenericTypeModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(GenericType<String>.self)
            .to(factory: GenericType.init)
    }
    
    
}
