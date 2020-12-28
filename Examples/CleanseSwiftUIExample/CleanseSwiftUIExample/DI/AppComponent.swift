//
//  AppComponent.swift
//  adoptme
//
//  Created by Abdul Chathil on 12/25/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Cleanse

struct AppComponent: Cleanse.RootComponent {
    typealias Root = PropertyInjector<AdoptmeApp>

    static func configure(binder: Binder<Singleton>) {
        binder.include(module: UserData.Module.self)
        binder.include(module: User.Module.self)
    }

    static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<AdoptmeApp>>) -> BindingReceipt<PropertyInjector<AdoptmeApp>> {
        bind.propertyInjector { (bind) -> BindingReceipt<PropertyInjector<AdoptmeApp>> in
            return bind.to(injector: AdoptmeApp.injectProperties)
        }
    }
}
