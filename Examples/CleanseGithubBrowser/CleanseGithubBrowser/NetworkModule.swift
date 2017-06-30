//
//  NetworkModule.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

/// Wires up NSURLSession and friends
struct NetworkModule : Module {
    static func configure(binder: SingletonBinder) {

        binder
            .bind()
            .sharedInScope()
            .to { URLSessionConfiguration.ephemeral }

        binder
            .bind(URLSession.self)
            .sharedInScope()
            .to { URLSession(configuration: $0, delegate: nil, delegateQueue: OperationQueue.main) }

        binder
            .bind(URL.self)
            .tagged(with: GithubBaseURL.self)
            .to(value: URL(string: "https://api.github.com")!)
    }
}
