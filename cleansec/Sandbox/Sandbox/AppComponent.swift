//
//  AppComponent.swift
//  Sandbox
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import Cleanse

struct AppComponent: RootComponent {
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(String.self)
            .to { (amount: Double) -> String in
                return "hello"
            }
        
        binder
            .bind(Double.self)
            .to(value: 3.0)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<Int>) -> BindingReceipt<Int> {
        return bind.to(value: 3)
    }
    
    typealias Root = Int
}
