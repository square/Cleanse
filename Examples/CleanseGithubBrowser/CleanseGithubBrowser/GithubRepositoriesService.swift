//
//  GithubRepositoriesService.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct GithubRepository {
    let name: String
    let watchersCount: Int

    static func fromJSON(json: [String: AnyObject]) -> GithubRepository {
        return .init(
            name: json["name"] as! String,
            watchersCount: json["watchers_count"] as! Int
        )
    }
}

/// Service that lists repositories for the current user
protocol GithubRepositoriesService {
    func list(handler: ErrorOptional<[GithubRepository]> -> ())
}

struct GithubRepositoriesServiceImpl : GithubRepositoriesService {
    let githubURL: TaggedProvider<GithubBaseURL>
    let githubOrganizationName: TaggedProvider<GithubOrganizationName>

    let urlSession: NSURLSession

    func list(handler: ErrorOptional<[GithubRepository]> -> ()) {
        urlSession.jsonListTask(
            baseURL: githubURL.get(),
            pathComponents: "users", githubOrganizationName.get(), "repos",
            query: "sort=updated") { result in
                handler(result.map {
                    $0.map(GithubRepository.fromJSON)
                })
        }
    }
}

/// Wires up GithubRepositoriesService to its implementation
struct GithubRepositoriesServiceModule : Module {
    func configure<B : Binder>(binder binder: B) {
        binder
            .bind(GithubRepositoriesService.self)
            .to(factory: GithubRepositoriesServiceImpl.init)
    }
}