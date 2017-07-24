//
//  Finalizable.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

protocol Finalizable {
    func finalize() throws
}

struct AnonymousFinalizable : Finalizable {
    let finalizeFunc: () throws -> Void

    func finalize() throws {
        try self.finalizeFunc()
    }
}

