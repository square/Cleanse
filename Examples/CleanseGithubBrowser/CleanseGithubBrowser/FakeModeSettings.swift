//
//  FakeModeSettingsItem.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Cleanse
import Foundation
import UIKit

struct FakeModeSettingsModule : Cleanse.Module {
    static func configure(binder: UnscopedBinder) {
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}

class FakeModeCell : UITableViewCell {
    let `switch` = UISwitch()
    let processInfo: ProcessInfo

    init(processInfo: ProcessInfo) {
        self.processInfo = processInfo

        super.init(style: .default, reuseIdentifier: nil)

        `switch`.isOn = processInfo.environment["USE_FAKES"] == "YES"
        `switch`.addTarget(self, action: #selector(valueChanged), for: .touchUpInside)

        textLabel?.text = "Fake Mode Enabled"

        accessoryView = `switch`
        selectionStyle = .none
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func valueChanged() {
        let textValue = `switch`.isOn ? "YES" : "NO"
        setenv("USE_FAKES", textValue, 1)

        // This is kinda bad, but since fake mode is a hack anyways...
        (UIApplication.shared.delegate! as! AppDelegate).resetApplication()
    }
}
