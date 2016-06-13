//
//  FakeModeSettingsItem.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse
import UIKit

struct FakeModeSettingsModule : Cleanse.Module {
    func configure<B : Binder>(binder binder: B) {

        binder.bind().to(factory: FakeModeSettingsSplitViewController.init)
        binder.bind().to(factory: FakeModeCell.init)

        binder
            .bind(SettingsItem.self)
            .intoCollection()
            .to { (viewController: Provider<FakeModeSettingsSplitViewController>) -> SettingsItem in
                let item = SettingsItem(title: "Fake Mode", viewControllerProvider: viewController, rank: 99)

                return item
            }
    }
}



class FakeModeSettingsSplitViewController : TableViewController {
    private let cells: [UITableViewCell]

    init(fakeModeCell: FakeModeCell) {

        self.cells = [fakeModeCell]

        super.init()

        self.title = "Fake Mode Settings"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}

class FakeModeCell : UITableViewCell {
    let `switch` = UISwitch()
    let processInfo: NSProcessInfo

    init(processInfo: NSProcessInfo) {
        self.processInfo = processInfo

        super.init(style: .Default, reuseIdentifier: nil)

        `switch`.on = processInfo.environment["USE_FAKES"] == "YES"

        `switch`.addTarget(self, action: #selector(valueChanged), forControlEvents: .TouchUpInside)

        textLabel?.text = "Fake Mode Enabled"

        accessoryView = `switch`
        selectionStyle = .None
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func valueChanged() {
        let textValue = `switch`.on ? "YES" : "NO"

        setenv("USE_FAKES", textValue, 1)

        // This is kinda bad, but since fake mode is a hack anywas...

        (UIApplication.sharedApplication().delegate! as! AppDelegate).resetApplication()
    }
}
