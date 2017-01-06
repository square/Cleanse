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

    struct ComponentWithInvalidScope1 : RootComponent {
        typealias Scope = Scope1
        typealias Root = Void

        static func configure<B : Binder>(binder binder: B) {
            binder
                .bind(String.self)
                .scoped(in: Scope2.self)
                .to(value: "fail")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: Void())
        }
    }

    func testBoundInWrongScope() {
        do {
            try ComponentFactory.of(ComponentWithInvalidScope1.self)
            XCTFail("Should not get here")
        } catch let e {
            Assert((e as! CleanseError).description, contains: "Invalid Scope")
        }
    }

    struct ComponentWithInvalidScope2 : RootComponent {
        typealias Scope = Scope1
        typealias Root = Void

        static func configure<B : Binder>(binder binder: B) {
            binder
                .bind(String.self)
                .asSingleton()
                .to(value: "fail")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: Void())
        }
    }

    func testBoundInWrongScope_2() {
        do {
            try ComponentFactory.of(ComponentWithInvalidScope2.self)
            XCTFail("Should not get here")
        } catch let e {
            Assert((e as! CleanseError).description, contains: "Invalid Scope")
        }
    }

    struct SomeScopedStruct : Scoped {
        typealias Scope = Scope2
    }

    struct ComponentWithInvalidScope_ViaScoped : RootComponent {
        typealias Scope = Scope1
        typealias Root = String

        static func configure<B : Binder>(binder binder: B) {
            binder
                .bind(SomeScopedStruct.self)
                .to(value: SomeScopedStruct())
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: "Omg")
        }
    }

    func testBoundInWrongScope_viaScoped() {
        do {
            try ComponentFactory.of(ComponentWithInvalidScope_ViaScoped.self)
            XCTFail("Should not get here")
        } catch let e {
            Assert((e as! CleanseError).description, contains: "Invalid Scope")
        }
    }

    struct ComponentWithInvalidInnerComponent : RootComponent {
        typealias Scope = Scope1
        typealias Root = String

        static func configure<B : Binder>(binder binder: B) {
            binder.install(dependency: InvalidInnerComponent.self)

            binder.bind().to { ($0 as ComponentFactory<InvalidInnerComponent>).build() }
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: "Omg")
        }
    }

    struct InvalidInnerComponent : Component {
        typealias Scope = Scope2
        typealias Root = Void

        static func configure<B : Binder>(binder binder: B) {
            binder
                .bind(String.self)
                .scoped(in: Scope1.self)
                .to(value: "fail")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: Void())
        }
    }

    func testBoundInWrongScope_nestedSubcomponents() {
        do {
            try ComponentFactory.of(ComponentWithInvalidInnerComponent.self)
            XCTFail("Should not get here")
        } catch let e {
            Assert((e as! CleanseError).description, contains: "Invalid Scope")
        }
    }

    struct ComponentWithInvalidInnerComponentWithSameScope : RootComponent {
        typealias Scope = Scope1
        typealias Root = String

        static func configure<B : Binder>(binder binder: B) {
            binder.install(dependency: InvalidInnerComponentWithSameScope.self)

            binder.bind().to { ($0 as ComponentFactory<InvalidInnerComponentWithSameScope>).build() }
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: "Omg")
        }
    }

    struct InvalidInnerComponentWithSameScope : Component {
        typealias Scope = Scope1
        typealias Root = Void

        static func configure<B : Binder>(binder binder: B) {
            binder
                .bind(String.self)
                .scoped(in: Scope1.self)
                .to(value: "fail")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(value: Void())
        }
    }

    func testNestedDuplicateScopes() {
        do {
            try ComponentFactory.of(ComponentWithInvalidInnerComponentWithSameScope.self)
            XCTFail("Should not get here")
        } catch let e {
            Assert((e as! CleanseError).description, contains: "with the same scope: (Scope1)")
        }
    }
}
