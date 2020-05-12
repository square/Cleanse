//
//  TaggedProviderDependency.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct MyTag2: Tag {
    typealias Element = Int
}

struct TaggedDependency {
    let provider: TaggedProvider<MyTag2>
}
struct TaggedDepModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.bind(TaggedDependency.self).to(factory: TaggedDependency.init)
    }
}
