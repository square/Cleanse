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
        let username = json["login"] as! String
        return GithubMember(login: username)
    }
}

/// Service that lists "Member" for the current organization
protocol GithubMembersService {
    func list(handler: @escaping (ErrorOptional<[GithubMember]>) -> Void)
}

struct GithubMembersServiceImpl : GithubMembersService {
    let githubURL: TaggedProvider<GithubBaseURL>
    let githubOrganizationName: TaggedProvider<GithubOrganizationName>

    let urlSession: URLSession

    /// Lists members of an organization
    func list(handler: @escaping (ErrorOptional<[GithubMember]>) -> Void) {
        urlSession.jsonListTask(
            baseURL: githubURL.get(),
            pathComponents: "orgs", githubOrganizationName.get(), "public_members") { result in
                handler(result.map {
                    $0.map(GithubMember.fromJSON)
                })
        }
    }
}
