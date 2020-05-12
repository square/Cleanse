//
//  PropertyInjectorRoot.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

class MainPropertyClass {
    static func configureAppDelegateInjector(binder bind: PropertyInjectionReceiptBinder<MainPropertyClass>) -> BindingReceipt<PropertyInjector<MainPropertyClass>> {
        return bind.to { (a, number:Int) in
            // Noop
        }
    }
}

struct RootComponent: Cleanse.RootComponent {
    static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<MainPropertyClass>>) -> BindingReceipt<PropertyInjector<MainPropertyClass>> {
        return bind.propertyInjector(configuredWith: MainPropertyClass.configureAppDelegateInjector)
    }
    
    typealias Root = PropertyInjector<MainPropertyClass>
    
    static func configure(binder: Binder<Unscoped>) {
    }
}
