//
//  AppComponent.swift
//  CleanseGithubBrowser
//
//  Created by holmes on 9/21/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Cleanse
import UIKit

// ----------------------- CxFImplWiring

struct CheckoutFlowModule: Module {
    static func configure(binder: Binder<CheckoutFlowScope>) {
        binder.bind(Int.self).to(value: 3)
    }
    
    
}

struct CheckoutFlowModule2: Module {
    static func configure(binder: Binder<CheckoutFlowScope>) {
        binder.bind(Int.self).to(value: 5)
    }
    
    
}

struct CheckoutFlowScope: Scope {}

protocol CheckoutFlowModules: Cleanse.Module where Scope == CheckoutFlowScope {}

struct CheckoutFlowComponent<M:CheckoutFlowModules>: Cleanse.Component {
    static func configure(binder: Binder<CheckoutFlowScope>) {
        binder.include(module: M.self)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<String>) -> BindingReceipt<String> {
        return bind.to(value: "Hello")
    }
    
    typealias Root = String
    
    
}


// ----------------------- LoggedInImplWiring

struct LoggedInScope: Scope {}

protocol LoggedInModules: Cleanse.Module where Scope == LoggedInScope {}

struct LoggedInComponent<M:LoggedInModules>: Cleanse.RootComponent {
    static func configure(binder: Binder<LoggedInScope>) {
        binder.include(module: M.self)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<UIViewController>) -> BindingReceipt<UIViewController> {
        return bind.to(value: UIViewController(nibName: nil, bundle: nil))
    }
    
    typealias Root = UIViewController
    
    
}

// ------------------------ App

struct SomeLoggedInModule: Cleanse.Module {
    static func configure(binder: Binder<LoggedInScope>) {
        
    }
    
    
}

struct POSCheckoutFlowModules: CheckoutFlowModules {
    static func configure(binder: Binder<CheckoutFlowScope>) {
        binder.include(module: CheckoutFlowModule.self)
    }

}

struct APOSCheckoutFlowModules: CheckoutFlowModules {
    static func configure(binder: Binder<CheckoutFlowScope>) {
        binder.include(module: CheckoutFlowModule.self)
    }

}

struct POSLoggedInModules: LoggedInModules {
    static func configure(binder: Binder<LoggedInScope>) {
        binder.include(module: SomeLoggedInModule.self)
        
        binder.install(dependency: CheckoutFlowComponent<POSCheckoutFlowModules>.self)
    }
    
    
}

struct AppointmentsLoggedInModules: LoggedInModules {
    static func configure(binder: Binder<LoggedInScope>) {
        
    }
    
}

struct AppComponent<ServiceModule: GithubServicesModule> : Cleanse.RootComponent where ServiceModule.Scope == Singleton {
    typealias Root = PropertyInjector<AppDelegate>
    typealias Scope = Singleton

    static func configure(binder: SingletonBinder) {
        binder.include(module: CoreAppModule.self)
        binder.include(module: ServiceModule.self)
        binder.install(dependency: LoggedInComponent<POSLoggedInModules>.self)

        #if DEBUG
        binder.include(module: FakeModeSettingsModule.self)
        #endif

        binder.bind().configured(with: ServiceModule.configureGithubMembersService)
        binder.bind().configured(with: ServiceModule.configureRepositoriesMembersService)
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
