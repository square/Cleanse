//
//  NoopVisitor.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/3/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

import XCTest

@testable import Cleanse

final class NoopVisitor : SimpleComponentVisitor {
    var visitorState = VisitorState<NoopVisitor>()
}
