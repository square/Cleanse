//
//  ErrorOptional.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// Represents either an error or result type.
enum ErrorOptional<Wrapped> {
    case Result(Wrapped)
    case Error(Error)


    init(_ result: Wrapped) {
        self = .Result(result)
    }

    init(_ error: Error) {
        self = .Error(error)
    }

    func get() throws -> Wrapped {
        switch self {
        case let .Result(result):
            return result
        case let .Error(error):
            throw error
        }
    }
}


extension ErrorOptional {
    func map<NewWrapped>(transform: (Wrapped) throws -> NewWrapped) -> ErrorOptional<NewWrapped> {
        switch self {
        case let .Result(result):
            do {
                return try .init(transform(result))
            } catch let e {
                return .init(e)
            }
        case let .Error(error):
            return .init(error)
        }
    }
}
