//
//  AppDelegate.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import UIKit
import Cleanse


typealias ReleaseAppComponent = AppComponent<RealeaseGithubServicesModule>
typealias FakeAppComponent = AppComponent<FakeGithubServicesModule>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        resetApplication()
        return true
    }

    func resetApplication() {
        // Attempt to build the component we defined below Build returns the `Root` type we defined
        let propertyInjector: PropertyInjector<AppDelegate>

        // Fake mode makes it easy to test and demo the app. It uses in process versions of the services
        if useFakeMode {
            // Build and validate the release module to catch bugs sooner.
            let _ = try! ComponentFactory.of(ReleaseAppComponent.self)
            
            propertyInjector = try! ComponentFactory.of(FakeAppComponent.self).build()
        } else {
            propertyInjector = try! ComponentFactory.of(ReleaseAppComponent.self, validate: false).build()
        }

        // Now inject the properties into ourselves
        propertyInjector.injectProperties(into: self)

        // window should now be defined
        precondition(window != nil)

        window!.makeKeyAndVisible()
    }

    // This doesn't use DI since we need to know whether or not to use fake mode outside the context of the the component
    fileprivate var useFakeMode: Bool {
        return ProcessInfo.processInfo.environment["USE_FAKES"] == "YES"
    }
}

extension AppDelegate {
    /// Since we don't control creation of our AppDelegate, we have to use "property injection" to populate 
    /// our required properties
    func injectProperties(_ window: UIWindow) {
        self.window = window
    }
}
