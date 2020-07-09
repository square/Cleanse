//
//  SimpleComponent.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct Subcomponent2: Component {
    static func configure(binder: Binder<Unscoped>) {
        
    }
    static func configureRoot(binder bind: ReceiptBinder<Int>) -> BindingReceipt<Int> {
        return bind.to(value: 3)
    }
    typealias Root = Int
}

fileprivate struct Container {
    fileprivate struct NestedSubcomponent: Component {
        static func configure(binder: Binder<Unscoped>) {
            
        }
        static func configureRoot(binder bind: ReceiptBinder<Int>) -> BindingReceipt<Int> {
            return bind.to(value: 3)
        }
        typealias Root = Int
    }
}
