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
        
    struct TestComponent : Cleanse.Component {
        typealias Root = TestRoot
        
        func configure<B : Binder>(binder binder: B) {
            binder.bind().to(factory: TestRoot.init)
            
            binder.bind(String.self).to(value: "Hey!")
        }
    }
    
    func testCanonicalRepresentable() {
        let root = try! TestComponent().build()
        
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
        let bar = try! BarComponent().build()
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

    struct BarComponent : Cleanse.Component {
        typealias Root = Bar

        func configure<B : Binder>(binder binder: B) {
            binder
                .bind(Bar.self)
                .to(factory: Bar.init)

            binder
                .bind(FooProto.self)
                .to(factory: Foo.init)
        }
    }

}


protocol FooProto {
}

