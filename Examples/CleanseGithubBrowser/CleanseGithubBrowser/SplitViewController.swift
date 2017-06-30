//
//  SplitViewController.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import UIKit

/// Common base class for UISplitViewController that has better default constructors
class SplitViewController : UISplitViewController {
    init<RootVC: UIViewController>(masterViewController: RootVC) where RootVC: UISplitViewControllerDelegate {
        super.init(nibName: nil, bundle: nil)

        self.delegate = masterViewController
        self.viewControllers = [UINavigationController(rootViewController: masterViewController)]
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
