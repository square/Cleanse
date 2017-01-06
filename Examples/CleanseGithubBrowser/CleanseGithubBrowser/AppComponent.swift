//
//  AppComponent.swift
//  CleanseGithubBrowser
//
//  Created by holmes on 9/21/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Cleanse



struct AppComponent<ServicesModule: GithubServicesModule> : Cleanse.RootComponent {
    typealias Root = PropertyInjector<AppDelegate>
    typealias Scope = Singleton

    static func configure<B : Binder>(binder binder: B) {
        binder.install(module: CoreAppModule.self)

        binder.install(module: ServicesModule.self)

        #if DEBUG

        binder.install(module: FakeModeSettingsModule.self)

        #endif

        binder.bind().configured(with: ServicesModule.configureGithubMembersService)
        binder.bind().configured(with: ServicesModule.configureRepositoriesMembersService)
    }

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.propertyInjector(configuredWith: CoreAppModule.configureAppDelegateInjector)
    }
}

struct CoreAppModule : Cleanse.Module {
    static func configure<B : Binder>(binder binder: B) {
        // We want to make it so the app uses "square" as the github user.
        binder
            .bind()
            .tagged(with: GithubOrganizationName.self)
            .to(value: "square")

        // Bind common dependencies.
        binder.install(module: FoundationCommonModule.self)
        binder.install(module: UIKitCommonModule.self)

        // This will wire up our root view controller.
        binder.install(module: RootViewController.Module.self)
        binder.install(module: SettingsSplitViewController.Module.self)

        binder.install(module: RepositoriesModule.self)
        binder.install(module: MembersModule.self)
    }

    static func configureAppDelegateInjector(binder bind: PropertyInjectionReceiptBinder<AppDelegate>) -> BindingReceipt<PropertyInjector<AppDelegate>> {
        return bind.to(injector: AppDelegate.injectProperties)
    }
}
