//
//  RootViewController.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Cleanse
import UIKit

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
            .sorted { $0.rank < $1.rank  }
            .map { $0.viewController }

        self.viewControllers = viewControllers
        self.selectedViewController = viewControllers.first!
    }

    /// We declare this unavailable. This makes it so its unambiguous when referring to `RootViewController.init`
    /// we get the constructor we want
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    struct Module : Cleanse.Module {
        static func configure(binder: UnscopedBinder) {
            // This creates and binds a RootViewController.
            binder
                .bind(RootViewController.self)
                .to(factory: RootViewController.init)

            // This satisfies UIWindow wanting the TaggedProvider<UIViewController.Root> 
            // with the RootViewController created above.
            binder
                .bind()
                .tagged(with: UIViewController.Root.self)
                .to { $0 as RootViewController }
        }
    }
}

