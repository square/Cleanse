//
//  DecoratedReferenceProvider.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct Box {
    let a: Array<Int>
}

struct MyTag3: Tag {
    typealias Element = Box
}

struct DecoratedModule: Module {
    static func configureA(b: ReceiptBinder<Box>) -> BindingReceipt<Box> {
        return b.to(factory: Box.init)
    }
    
    static func configure(binder: Binder<Singleton>) {
        binder.bind(Box.self).sharedInScope().configured(with: configureA)
        binder.bind(Box.self).tagged(with: MyTag3.self).configured(with: configureA)
    }
}
