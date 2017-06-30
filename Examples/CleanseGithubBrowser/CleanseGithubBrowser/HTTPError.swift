//
//  HTTPError.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


struct HTTPError : Error {
    let statusCode: Int

    /// - returns: nil if status code isn't an error code
    init?(statusCode: Int) {
        guard 400..<600 ~= statusCode else {
            return nil
        }

        self.statusCode = statusCode
    }
}
