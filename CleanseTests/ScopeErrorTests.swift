//
//  ScopeErrorTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 8/1/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

import XCTest

@testable import Cleanse

struct Scope1 : Scope {
}

struct Scope2 : Scope {
}

class ScopeErrorTests: XCTestCase {

    struct ComponentWithInvalidScope2 : RootComponent {
        typealias Scope = Scope1
        typealias Root = Void

        static func configure(binder: Binder<Scope1>) {
            binder
                .bind(String.self)
                .sharedInScope()
                .to(value: "fail")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: Void())
        }
    }

    struct SomeScopedStruct {
    }


    struct ComponentWithInvalidInnerComponentWithSameScope : RootComponent {
        typealias Root = String

        static func configure(binder: Binder<Scope1>) {
            binder.install(dependency: InvalidInnerComponentWithSameScope.self)

            binder.bind().to { ($0 as ComponentFactory<InvalidInnerComponentWithSameScope>).build(()) }
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: "Omg")
        }
    }

    struct InvalidInnerComponentWithSameScope : Component {
        typealias Root = Void

        static func configure(binder: Binder<Scope1>) {
            binder
                .bind(String.self)
                .sharedInScope()
                .to(value: "fail")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: Void())
        }
    }

    func testNestedDuplicateScopes() {
        do {
            _ = try ComponentFactory.of(ComponentWithInvalidInnerComponentWithSameScope.self)
            XCTFail("Should not get here")
        } catch let e {
            Assert((e as! CleanseError).description, contains: "with the same scope: (Scope1)")
        }
    }
}
