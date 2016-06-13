//
//  GithubServicesModule.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

/// Wires up common definitions shared across services as well as installing the services's modules
struct GithubServicesModule : Module {
    func configure<B : Binder>(binder binder: B) {
        binder.install(module: GithubMembersServiceModule())
        binder.install(module: GithubRepositoriesServiceModule())
    }
}




struct GithubBaseURL : Tag {
    typealias Element = NSURL
}

/// Represents the github user name we want to query
struct GithubUserName : Tag {
    typealias Element = String
}
struct GithubOrganizationName : Tag {
    typealias Element = String
}