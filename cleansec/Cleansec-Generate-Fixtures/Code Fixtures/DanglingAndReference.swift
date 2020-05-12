//
//  DanglingAndReference.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct MyOtherWorld2 {
    static func configureMyA(aaaa: ReceiptBinder<Dangling>) -> BindingReceipt<Dangling> {
        return aaaa.to(factory: Dangling.init)
    }
}

struct MyModule: Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.bind(Dangling.self).configured(with: MyOtherWorld2.configureMyA)
    }
}
