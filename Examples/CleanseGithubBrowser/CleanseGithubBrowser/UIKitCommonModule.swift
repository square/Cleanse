//
//  AppModule.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import UIKit
import Cleanse

/// Define common UIKit bindings.

extension UIScreen {
    /// This is a simple module that binds UIScreen.mainScreen() to UIScreen
    public struct Module : Cleanse.Module {
        public static func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(factory: UIScreen.mainScreen)
        }
    }
}

extension UIWindow {
    /// This is the module that configures how we build our main window. It ias assumed when one requests
    /// injection of an un-tagged UIWindow, we will be giving them the "main" or "key" window.
    public struct Module : Cleanse.Module {
        public static func configure<B : Binder>(binder binder: B) {
            binder
                .bind(UIWindow.self)
                .asSingleton()
                .to { (rootViewController: TaggedProvider<UIViewController.Root>) in
                    let window = UIWindow(frame: UIScreen.mainScreen().bounds)
                    window.rootViewController = rootViewController.get()
                    return window
            }
        }
    }
}

extension UIViewController {
    /// This will represent the rootViewController that is assigned to our main window
    public struct Root : Tag {
        public typealias Element = UIViewController
    }
}


public struct UIKitCommonModule : Module {
    public static func configure<B : Binder>(binder binder: B) {
        // Install our common modules for UIScreen and UIWindow
        binder.include(module: UIScreen.Module.self)
        binder.include(module: UIWindow.Module.self)
    }
}
