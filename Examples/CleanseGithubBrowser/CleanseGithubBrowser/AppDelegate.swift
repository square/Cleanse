//
//  AppDelegate.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import UIKit
import Cleanse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        resetApplication()

        // Override point for customization after application launch.
        return true
    }


    func resetApplication() {
        // Attempt to build the component we defined below Build returns the `Root` type we defined
        let propertyInjector: PropertyInjector<AppDelegate>

        // Fake mode makes it easy to test and demo the app. It uses in process versions of the services
        if useFakeMode {
            propertyInjector = try! Component().withOverrides(overrideModule: FakeModeModule()).build()
        } else {
            propertyInjector = try! Component().build()
        }

        // Now inject the properties into ourselves
        propertyInjector.injectProperties(into: self)

        // window should now be defined
        precondition(window != nil)

        window!.makeKeyAndVisible()
    }

    // This doesn't use DI since we need to know whether or not to use fake mode outside the context of the the component
    private var useFakeMode: Bool {
        return NSProcessInfo.processInfo().environment["USE_FAKES"] == "YES"
    }
}

extension AppDelegate {
    /// Since we don't control creation of our AppDelegate, we have to use "property injection" to populate 
    /// our required properties
    func injectProperties(window: UIWindow) {
        self.window = window
    }


    /// This is the root component for the app. The Root type is a property injector which populates the root window
    struct Component : Cleanse.Component {
        typealias Root = PropertyInjector<AppDelegate>

        func configure<B : Binder>(binder binder: B) {
            binder
                .bindPropertyInjectionOf(AppDelegate.self)
                .to(injector: AppDelegate.injectProperties)


            // We want to make it so the app uses "square" as the github user
            binder
                .bind()
                .tagged(with: GithubOrganizationName.self)
                .to(value: "square")
            

            // UIKitCommonModule has useful shared bindings
            binder.install(module: UIKitCommonModule())
            // This will wire up our root view controller.
            binder.install(module: RootViewController.Module())
            binder.install(module: SettingsSplitViewController.Module())

            binder.install(module: RepositoriesModule())
            binder.install(module: MembersModule())

            binder.install(module: GithubServicesModule())
            binder.install(module: NetworkModule())

            binder.install(module: FoundationCommonModule())

            binder.install(module: FakeModeSettingsModule())
        }
    }
}


#if DEBUG

    extension AppDelegate {
        // This overrides the regular component in debug mode to allow us to use fake services

        struct FakeModeModule : OverrideModule {
            // We override our component with fakes
            typealias Overrides = AppDelegate.Component

            func configure<B : Binder>(binder binder: B) {
                binder.install(module: FakeGithubServiceModule())
            }
        }
    }

#endif
