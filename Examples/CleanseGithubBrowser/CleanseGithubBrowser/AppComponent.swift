//
//  AppComponent.swift
//  CleanseGithubBrowser
//
//  Created by holmes on 9/21/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Cleanse

struct ReleaseAppComponent : Cleanse.RootComponent {
    typealias Root = PropertyInjector<AppDelegate>
    typealias Scope = Singleton

    static func configure<B : Binder>(binder binder: B) {
        binder.install(module: CoreAppModule.self)

        binder.install(module: GithubServicesModule.self)
        binder.install(module: NetworkModule.self)
    }
}

#if DEBUG

struct FakeAppComponent : Cleanse.RootComponent {
    typealias Root = PropertyInjector<AppDelegate>
    typealias Scope = Singleton

    static func configure<B : Binder>(binder binder: B) {
        binder.install(module: CoreAppModule.self)

        binder.install(module: FakeGithubServiceModule.self)
        binder.install(module: FakeModeSettingsModule.self)
    }
}

#endif

struct CoreAppModule : Cleanse.Module {
    static func configure<B : Binder>(binder binder: B) {
        binder
            .bindPropertyInjectionOf(AppDelegate.self)
            .to(injector: AppDelegate.injectProperties)

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
}
