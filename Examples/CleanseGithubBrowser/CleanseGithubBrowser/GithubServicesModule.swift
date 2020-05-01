//
//  GithubServicesModule.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse


protocol GithubServicesModule : Module {
    static func configureGithubMembersService(binder bind: ReceiptBinder<GithubMembersService>) -> BindingReceipt<GithubMembersService>
    static func configureRepositoriesMembersService(binder bind: ReceiptBinder<GithubRepositoriesService>) -> BindingReceipt<GithubRepositoriesService>
}


/// Wires up common definitions shared across services as well as installing the services's modules
struct RealeaseGithubServicesModule : GithubServicesModule {
    struct A {
        let string: String
    }
    static func configure(binder: SingletonBinder) {
        binder.include(module: NetworkModule.self)
        binder
            .bind(URLSessionConfiguration.self)
            .sharedInScope()
            .to { (a: String) in
                return URLSessionConfiguration.ephemeral
        }

        binder
            .bind(A.self)
            .to(factory: A.init)
        
        binder
            .bind(GithubMembersService.self).configured(with: configureGithubMembersService)
    }

    static func configureGithubMembersService(binder bind: ReceiptBinder<GithubMembersService>) -> BindingReceipt<GithubMembersService> {
        return bind.to(factory: GithubMembersServiceImpl.init)
    }

    static func configureRepositoriesMembersService(binder bind: ReceiptBinder<GithubRepositoriesService>) -> BindingReceipt<GithubRepositoriesService> {
        return bind.to(factory: GithubRepositoriesServiceImpl.init)
    }
}

struct GithubBaseURL : Tag {
    typealias Element = URL
}

/// Represents the github user name we want to query.
struct GithubUserName : Tag {
    typealias Element = String
}

struct GithubOrganizationName : Tag {
    typealias Element = String
}
