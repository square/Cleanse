//
//  FoundationCommonModule.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

/// Module that configures common bindings from the `Foundation` framework
struct FoundationCommonModule : Module {
    static func configure(binder: SingletonBinder) {
        binder
            .bind(ProcessInfo.self)
            .to { ProcessInfo.processInfo }
    }
}
