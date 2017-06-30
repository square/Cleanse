//
//  SettingsSplitViewController.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse
import UIKit


/// These can be provided to a collection to add an item to settings.
struct SettingsItem {
    /// title in the tableview
    let title: String

    /// This is a provider of the view controller of the settings item
    let viewControllerProvider: Provider<UIViewController>

    /// Order you want your settings item to appear.
    let rank: Int

    /// Initializer that will automatically map a provider of a subclass of UIViewController to a UIViewController provider
    init<VC: UIViewController>(
        title: String,
        viewControllerProvider: Provider<VC>,
        rank: Int
    ) {
        self.title = title
        self.rank = rank
        self.viewControllerProvider = viewControllerProvider.map { $0 }
    }

    /// Initializer which takes a viewController value
    init<VC: UIViewController>(
        title: String,
        viewController: VC,
        rank: Int
    ) {
        self.title = title
        self.rank = rank
        self.viewControllerProvider = Provider { viewController }
    }

}

/// Split view controller that has settings items as the Master, and the settings details as the detail item
class SettingsSplitViewController : SplitViewController {
    init(masterViewController: MasterViewController) {
        super.init(masterViewController:  masterViewController)

        self.title = "Settings"

        self.tabBarItem.image = UIImage(
            named: "TabBarIcons/Settings",
            in: Bundle(for: type(of: self)),
            compatibleWith: nil
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    /// Module that adds SettingsSplitViewController & friends
    struct Module : Cleanse.Module {
        static func configure(binder: UnscopedBinder) {
            binder.bind().to(factory: SettingsSplitViewController.init)
            binder.bind().to(factory: MasterViewController.init)

            // Bind an empty list to Settings in case there aren't any.
            binder
                .bind(SettingsItem.self)
                .intoCollection()
                .to(value: [])

            // Add a dummy VC to settings for now
            binder
                .bind(RootTabBarItem.self)
                .intoCollection()
                .to { (SettingsSplitViewController: SettingsSplitViewController) -> RootTabBarItem in
                    return RootTabBarItem(viewController: SettingsSplitViewController, rank: 10)
                }
        }
    }
}

extension SettingsSplitViewController  {
    /// Master view controller for the Settings split view controller.
    /// A lot of this implementation could be split into a generic SplitViewController implementation
    class MasterViewController : TableViewController {
        let settingsItems: [SettingsItem]

        fileprivate var lastSelectedItemIndex: Int?

        /// Our master view controller takes a list of `SettingsItems` to display.
        required init(settingsItems: [SettingsItem]) {
            self.settingsItems = settingsItems.sorted { $0.rank < $1.rank }
            super.init()

            self.clearsSelectionOnViewWillAppear = false
            self.title = "Settings"
        }

        var splitViewControllerIsCollapsed: Bool {
            return splitViewController?.isCollapsed ?? false
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            deselectRowIfCollapsed(animated: animated)
            selectDefaultItemIfExpanded(animated: animated)

            // If the view controller is collapsed and we're appearing, it implies that the user explicitely hit the back button
            if splitViewControllerIsCollapsed && !isMovingToParentViewController {
                self.lastSelectedItemIndex = nil
            }
        }

        fileprivate func selectDefaultItemIfExpanded(animated: Bool) {
            guard !splitViewControllerIsCollapsed else {
                return
            }

            let itemIndex = lastSelectedItemIndex ?? defaultItemIndex
            let targetIndexPath = IndexPath(row: itemIndex, section: 0)

            if tableView.indexPathForSelectedRow != targetIndexPath {
                tableView.selectRow(
                    at: targetIndexPath,
                    animated: animated,
                    scrollPosition: .none
                )
            }

            if self.splitViewController?.viewControllers.count == 1 {
                showItem(atIndex: itemIndex)
            }
        }

        fileprivate func deselectRowIfCollapsed(animated: Bool) {
            guard splitViewControllerIsCollapsed else {
                return
            }

            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                return
            }

            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
        private func selectAndShowItem(atIndex index: Int, animated: Bool) {
            tableView.selectRow(
                at: IndexPath(row: index, section: 0),
                animated: animated,
                scrollPosition: .none
            )

            showItem(atIndex: index)
        }

        fileprivate func showItem(atIndex index: Int) {
            showDetailViewController(detailViewControllerForItem(atIndex: index), sender: self)
        }

        fileprivate func detailViewControllerForItem(atIndex index: Int) -> UINavigationController {
            let item = settingsItems[index]

            return UINavigationController(rootViewController: item.viewControllerProvider.get())
        }

        fileprivate var defaultItemIndex: Int {
            return 0
        }
    }
}

/// TableView delegate stuff
extension SettingsSplitViewController.MasterViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = settingsItems[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = item.title
        updateDisclosureForCell(cell: cell, collapsed: splitViewControllerIsCollapsed)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedItemIndex = indexPath.row
        showItem(atIndex: indexPath.row)
    }
}

/// Split view controller delegate stuff
extension SettingsSplitViewController.MasterViewController : UISplitViewControllerDelegate {
    @objc func splitViewController(
        splitViewController: UISplitViewController,
        separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController
    ) -> UIViewController? {

        // If we started out in compact mode, then it wants us to split, we need to detect what the detail
        // view controller should be
        let primaryViewController = primaryViewController as! UINavigationController

        // The primary view controller, may have a nexted UINavigationController. If this is the case, we let it do its default thing
        if let topViewController = primaryViewController.topViewController, topViewController is UINavigationController {
            return nil
        }

        // If we aren't within a settings page, just return the default view controller
        return detailViewControllerForItem(atIndex: lastSelectedItemIndex ?? defaultItemIndex)
    }

    func splitViewController(
        splitViewController: UISplitViewController,
        collapseSecondaryViewController secondaryViewController: UIViewController,
        ontoPrimaryViewController primaryViewController: UIViewController
    ) -> Bool {
        /// Returning true here will make it so we revert to seeing the master view controller
        return !detailItemHasBeenExplicitelySelected
    }

    private var detailItemHasBeenExplicitelySelected: Bool {
        return lastSelectedItemIndex != nil
    }


    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // We use this to update whether or not we show disclosures, etc.

        updateCellDisclosuresAndSelection()
    }

    private func updateCellDisclosuresAndSelection() {
        let collapsed = splitViewControllerIsCollapsed
        for c in tableView.visibleCells {
            updateDisclosureForCell(cell: c, collapsed: collapsed)
        }

        deselectRowIfCollapsed(animated: false)
        selectDefaultItemIfExpanded(animated: false)
    }

    fileprivate func updateDisclosureForCell(cell: UITableViewCell, collapsed: Bool) {
        let accessoryType = collapsed ? UITableViewCellAccessoryType.disclosureIndicator : .none

        if cell.accessoryType != accessoryType {
            cell.accessoryType = accessoryType
        }
    }
}
