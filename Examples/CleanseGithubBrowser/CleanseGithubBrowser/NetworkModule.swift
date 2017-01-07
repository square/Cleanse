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
    static func configure<B : Binder>(binder binder: B) {

        binder
            .bind()
            .asSingleton()
            .to(factory: NSURLSessionConfiguration.ephemeralSessionConfiguration)

        binder
            .bind(NSURLSession.self)
            .asSingleton()
            .to {
                NSURLSession(configuration: $0, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
            }

        binder
            .bind()
            .tagged(with: GithubBaseURL.self)
            .to(value: NSURL(string: "https://api.github.com")!)
    }
}
