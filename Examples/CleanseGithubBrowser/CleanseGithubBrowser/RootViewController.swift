//
//  RootViewController.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import UIKit
import Cleanse


// Adding to a collection of this will make one appear on the tab bar
struct RootTabBarItem {
    // The view controller we add as an item
    let viewController: UIViewController

    // This is how we sort the entries
    let rank: Int
}

/// Root View Controller for our application
class RootViewController : UITabBarController {
    /// We want a list of RootTabBarItem's injected into us. These are the tabs we display
    init(items: [RootTabBarItem]) {
        super.init(nibName: nil, bundle: nil)

        /// Sort the view controllers by rank
        let viewControllers = items
            .sort { $0.rank < $1.rank  }
            .map { $0.viewController }

        self.viewControllers = viewControllers

        selectedViewController = viewControllers.first!
    }

    /// We declare this unavailable. This makes it so its unambiguous when referring to `RootViewController.init`
    /// we get the constructor we want
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configures RootViewController
    struct Module : Cleanse.Module {
        static func configure<B : Binder>(binder binder: B) {
            binder
                .bind(RootViewController.self)
                .to(factory: RootViewController.init)

            // This satiisfield UIWindow wanting the TaggedProvider<UIViewController.Root>
            binder
                .bind()
                .tagged(with: UIViewController.Root.self)
                .to { $0 as RootViewController }
        }
    }
}

