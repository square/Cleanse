//
//  AppComponent.swift
//  CleanseGithubBrowser
//
//  Created by holmes on 9/21/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Cleanse

struct TestAppComponent: Cleanse.RootComponent {
    typealias Root = PropertyInjector<AppDelegate>
    typealias Scope = Singleton

    static func configure(binder: SingletonBinder) {
        binder.include(module: CoreAppModule.self)
        binder.include(module: FakeGithubServicesModule.self)

        #if DEBUG
        binder.include(module: FakeModeSettingsModule.self)
        #endif
        
        binder.bind(Int.self).configured { (bind) -> BindingReceipt<Int> in
            bind.to(value: 3)
        }

        binder.bind().configured(with: FakeGithubServicesModule.configureGithubMembersService)
        binder.bind().configured(with: FakeGithubServicesModule.configureRepositoriesMembersService)
    }

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.propertyInjector(configuredWith: CoreAppModule.configureAppDelegateInjector)
    }
}

struct AppComponent : Cleanse.RootComponent {
    typealias Root = PropertyInjector<AppDelegate>
    typealias Scope = Singleton

    static func configure(binder: SingletonBinder) {
        binder.include(module: CoreAppModule.self)
        binder.include(module: RealeaseGithubServicesModule.self)

        #if DEBUG
        binder.include(module: FakeModeSettingsModule.self)
        #endif

        binder.bind().configured(with: RealeaseGithubServicesModule.configureGithubMembersService)
        binder.bind().configured(with: RealeaseGithubServicesModule.configureRepositoriesMembersService)
    }

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.propertyInjector(configuredWith: CoreAppModule.configureAppDelegateInjector)
    }
}


struct CoreAppModule : Cleanse.Module {
    static func configure(binder: SingletonBinder) {
        // We want to make it so the app uses "square" as the github user.
        binder
            .bind()
            .tagged(with: GithubOrganizationName.self)
            .to(value: "square")

        // Bind common dependencies.
        binder.include(module: FoundationCommonModule.self)
        binder.include(module: UIKitCommonModule.self)

        // This will wire up our root view controller.
        binder.include(module: RootViewController.Module.self)
        binder.include(module: SettingsSplitViewController.Module.self)

        binder.include(module: RepositoriesModule.self)
        binder.include(module: MembersModule.self)
    }

    static func configureAppDelegateInjector(binder bind: PropertyInjectionReceiptBinder<AppDelegate>) -> BindingReceipt<PropertyInjector<AppDelegate>> {
        return bind.to(injector: AppDelegate.injectProperties)
    }
}
