//
//  ComponentWithSeed.swift
//  Cleansec-Generate-Fixtures
//
//  Created by Sebastian Edward Shanus on 7/9/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import Cleanse

fileprivate struct MySeed {}

fileprivate struct SeededComponent: Cleanse.Component {
    typealias Root = Int
    typealias Seed = MySeed
    
    static func configure(binder: Binder<Unscoped>) {
        
    }
    
    static func configureRoot(binder bind: ReceiptBinder<Int>) -> BindingReceipt<Int> {
        return bind.to(value: 3)
    }
}
