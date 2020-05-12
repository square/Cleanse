//
//  ModuleWithTaggedProvider.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse


struct MyTag: Tag {
    typealias Element = A
}

struct CoreAppModule4 : Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder
            .bind(A.self)
            .tagged(with: MyTag.self)
            .sharedInScope()
            .to(factory: A.init)
    }
}
