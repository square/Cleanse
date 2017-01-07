//
//  DuplicateModulesTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 1/6/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation
import XCTest

@testable import Cleanse


private struct DupeRoot {
    let s1: TaggedProvider<S1>
    let s2: TaggedProvider<S2>
    let s3: TaggedProvider<S3>
}

private struct S1 : Tag {
    typealias Element = String
}

private struct S2 : Tag {
    typealias Element = String
}

private struct S3 : Tag {
    typealias Element = String
}

private struct M1 : Module {
    private static func configure<B : Binder>(binder binder: B) {
        binder.bind().tagged(with: S1.self).to(value: "s1")
        binder.include(module: M3.self)
    }
}
private struct M2 : Module {
    private static func configure<B : Binder>(binder binder: B) {
        binder.bind().tagged(with: S2.self).to(value: "s2")
        binder.include(module: M3.self)
    }
}

private struct M3 : Module {
    private static func configure<B : Binder>(binder binder: B) {
        binder.bind().tagged(with: S3.self).to(value: "s3")
    }
}

private struct DuplicateModuleComponent : RootComponent {
    typealias Root = DupeRoot

    private static func configure<B : Binder>(binder binder: B) {
        binder.include(module: M1.self)
        binder.include(module: M2.self)
    }

    private static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.to(factory: DupeRoot.init)
    }
}



/// Resolves https://github.com/square/Cleanse/issues/37
class DuplicateModulesTests: XCTestCase {
    func testDuplicateModuleIncludesOk() {
        let root = try! ComponentFactory.of(DuplicateModuleComponent.self).build()

        XCTAssertEqual(root.s1.get(), "s1")
        XCTAssertEqual(root.s2.get(), "s2")
        XCTAssertEqual(root.s3.get(), "s3")
    }
}

