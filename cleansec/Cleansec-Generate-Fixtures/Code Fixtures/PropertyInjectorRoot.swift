//
//  PropertyInjectorRoot.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

class MainPropertyClass {}

struct RootComponent: Cleanse.RootComponent {
    static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<MainPropertyClass>>) -> BindingReceipt<PropertyInjector<MainPropertyClass>> {
        return bind.to { (injector: PropertyInjector<MainPropertyClass>) -> PropertyInjector<MainPropertyClass> in
            return injector
        }
    }
    
    typealias Root = PropertyInjector<MainPropertyClass>
    
    static func configure(binder: Binder<Unscoped>) {
    }
}
