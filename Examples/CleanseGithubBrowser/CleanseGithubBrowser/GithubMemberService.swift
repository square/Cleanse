//
//  GithubService.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct GithubMember {
    let login: String

    static func fromJSON(json: [String: AnyObject]) -> GithubMember {
        return .init(
            login: json["login"] as! String
        )
    }
}

/// Service that lists "Member" for the current organization
protocol GithubMembersService {
    func list(handler: ErrorOptional<[GithubMember]> -> ())
}

struct GithubMembersServiceImpl : GithubMembersService {
    let githubURL: TaggedProvider<GithubBaseURL>
    let githubOrganizationName: TaggedProvider<GithubOrganizationName>

    let urlSession: NSURLSession

    /// Lists members of an organization
    func list(handler: ErrorOptional<[GithubMember]> -> ()) {
        urlSession.jsonListTask(
            baseURL: githubURL.get(),
            pathComponents: "orgs", githubOrganizationName.get(), "public_members") { result in
                handler(result.map {
                    $0.map(GithubMember.fromJSON)
                })
        }

    }
}

/// Hooks up GithubMembersService to its implementation
public struct GithubMembersServiceModule : Module {

    public func configure<B : Binder>(binder binder: B) {
        binder
            .bind(GithubMembersService.self)
            .to(factory: GithubMembersServiceImpl.init)
    }
}