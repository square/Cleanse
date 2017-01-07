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
struct FakeGithubServicesModule : GithubServicesModule {
    static func configure<B : Binder>(binder binder: B) {
        binder
            .bind()
            .asSingleton()
            .to(factory: FakeGithubMembersService.init)

        binder
            .bind()
            .asSingleton()
            .to(factory: FakeGithubRepositoriesService.init)
    }

    static func configureGithubMembersService(binder bind: ReceiptBinder<GithubMembersService>) -> BindingReceipt<GithubMembersService> {
        return bind.to { $0 as FakeGithubMembersService }
    }

    static func configureRepositoriesMembersService(binder bind: ReceiptBinder<GithubRepositoriesService>) -> BindingReceipt<GithubRepositoriesService> {
        return bind.to { $0 as FakeGithubRepositoriesService }
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
