//
//  CanonicalRepresentableTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

import XCTest

@testable import Cleanse

class CanonicalRepresentableTests: XCTestCase {
    
    struct TestRoot {
        let normal: String
        let implicitelyUnboxedOptional: String!
        let optional: String?
        
        #if SUPPORT_LEGACY_OBJECT_GRAPH
        
        let nsstring_normal: NSString
        let nsstring_implicitelyUnboxedOptional: NSString!
        let nsstring_optional: NSString?
        
        #endif
    }
        
    struct TestComponent : Cleanse.RootComponent {
        typealias Root = TestRoot
        
        static func configure(binder: UnscopedBinder) {
            binder.bind(String.self).to(value: "Hey!")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    func testCanonicalRepresentable() {
        let root = try! ComponentFactory.of(TestComponent.self).build(())

        XCTAssertEqual(root.normal, "Hey!")
        XCTAssertEqual(root.implicitelyUnboxedOptional, "Hey!")
        XCTAssertEqual(root.optional, "Hey!")
        
        #if SUPPORT_LEGACY_OBJECT_GRAPH
        
        XCTAssertEqual(root.nsstring_normal, "Hey!")
        XCTAssertEqual(root.nsstring_implicitelyUnboxedOptional, "Hey!")
        XCTAssertEqual(root.nsstring_optional, "Hey!")

        #endif
    }

    // verifies #26
    func testUnboxProtocol() {
        let bar = try! ComponentFactory.of(BarComponent.self).build(())
        XCTAssertNotNil(bar.foo)
    }


    struct Foo : FooProto {
    }

    struct Bar {
        var foo : FooProto?
        init(foo: FooProto?) {
            self.foo = foo
        }
    }

    struct BarComponent : Cleanse.RootComponent {
        typealias Root = Bar

        static func configureRoot(binder bind: ReceiptBinder<CanonicalRepresentableTests.Bar>) -> BindingReceipt<CanonicalRepresentableTests.Bar> {
            return bind.to(factory: Bar.init)
        }

        static func configure(binder: Binder<Unscoped>) {
            binder
                .bind(FooProto.self)
                .to(factory: Foo.init)
        }
    }

}


protocol FooProto {
}

