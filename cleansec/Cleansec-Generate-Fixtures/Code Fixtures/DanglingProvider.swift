//
//  DanglingProvider.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct Dangling {
    let number: Int
}
struct MyOtherWorld {
    static func configureMyInt(aaaa: ReceiptBinder<Dangling>) -> BindingReceipt<Dangling> {
        return aaaa.to(factory: Dangling.init)
    }
}

struct AModule: Module {
    static func configure(binder: Binder<Unscoped>) {
    }
    
    static func thisWorld(bbbb: ReceiptBinder<Int>) -> BindingReceipt<Int> {
        bbbb.to(value: 4)
    }
}
