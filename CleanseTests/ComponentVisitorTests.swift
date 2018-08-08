//
//  ComponentVisitorTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 10/4/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

import XCTest

@testable import Cleanse

class ComponentVisitorTests: XCTestCase {

    struct RootComponent : Cleanse.RootComponent {
        typealias Root = RR
        typealias Seed = String

    
        static func configure(binder: UnscopedBinder) {
            binder.install(dependency: Component1.self)
            binder.install(dependency: Component2.self)
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to { (cf1: ComponentFactory<Component1>, cf2: ComponentFactory<Component2>, s: String) in
                return RR(r1: cf1.build(()), r2: cf2.build(s))
            }
        }
    }

    struct RR {
        let r1: R1
        let r2: R2
    }

    struct Component1 : Cleanse.RootComponent {
        typealias Root = R1

        static func configure(binder: UnscopedBinder) {
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    struct Component2 : Cleanse.RootComponent {
        typealias Root = R2
        typealias Seed = String

        static func configure(binder: UnscopedBinder) {
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    struct R1 {
    }
    
    struct R2 {
        let foo: String
    }

    final class NoopVisitor : SimpleComponentVisitor {
        var visitorState: VisitorState<NoopVisitor> = .init()
    }

    func testNoopComponentVisitor() {
        let v =
            NoopVisitor()
        v.install(dependency: RootComponent.self)
    }

    func testNoopComponentVisitorValidate() {
        let root = try! ComponentFactory.of(RootComponent.self).build("Hi!")

        XCTAssertEqual(root.r2.foo, "Hi!")
    }
}
