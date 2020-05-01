//
//  ModuleIncludesSubcomponent.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse


struct Subcomponent: Component {
    static func configure(binder: Binder<Unscoped>) {
        
    }
    static func configureRoot(binder bind: ReceiptBinder<Int>) -> BindingReceipt<Int> {
        return bind.to(value: 3)
    }
    typealias Root = Int
}

struct CoreAppModule6 : Cleanse.Module {
    static func configure(binder: Binder<Unscoped>) {
        binder.install(dependency: Subcomponent.self)
    }
}
