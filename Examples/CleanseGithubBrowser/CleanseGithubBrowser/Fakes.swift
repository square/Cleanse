//
//  Fakes.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

/// Contains fake implementations of the services that use the network

/// Configure the services to be implemented by fakes
struct FakeGithubServiceModule : Module {
    static func configure<B : Binder>(binder binder: B) {
        /// Make it so when a GithubMembersService is requested, one gets a FakeGithubMembersService
        binder
            .bind(GithubMembersService.self)
            .asSingleton()
            .to(factory: FakeGithubMembersService.init)

        /// Make it so when a GithubRepositoriesService is requested, one gets a FakeGithubRepositoriesService
        binder
            .bind(GithubRepositoriesService.self)
            .asSingleton()
            .to(factory: FakeGithubRepositoriesService.init)
    }
}


struct FakeGithubMembersService : GithubMembersService {
    func list(handler: ErrorOptional<[GithubMember]> -> ()) {
        dispatch_async(dispatch_get_main_queue()) { 
            handler(.init([
                GithubMember(login: "abrons"),
                GithubMember(login: "mikelikespie"),
            ]))
        }
    }
}


struct FakeGithubRepositoriesService : GithubRepositoriesService {
    func list(handler: ErrorOptional<[GithubRepository]> -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            handler(.init([
                GithubRepository(name: "okhttp", watchersCount: 11_917),
                GithubRepository(name: "cleanse", watchersCount: 0),
            ]))
        }
    }
}