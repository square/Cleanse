//
//  InnerTag.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

fileprivate extension NSObject {
    /// This will represent the rootViewController that is assigned to our main window
    struct Root : Tag {
        typealias Element = NSObject
    }
}

struct InnerTagModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(NSObject.self)
            .tagged(with: NSObject.Root.self)
            .to(value: NSObject())
    }
}
