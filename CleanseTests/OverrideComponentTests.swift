//
//  OverrideComponentTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/3/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

import XCTest

@testable import Cleanse

protocol StringTag : Tag {
    associatedtype Element = String
}

class OverrideComponentTests: XCTestCase {
    
    /// Just make sure we can construct the graph without overrides
    func testSanity() {
        let root = try! OuterComponent().build()
        XCTAssertEqual(root.a.a1.value, "A_1")
        XCTAssertEqual(root.a.a2.value, "A_2")
        XCTAssertEqual(root.b.b1.value, "B_1")
        XCTAssertEqual(root.b.b2.value, "B_2")
    }
    
    func testOverrides() {
        let root = try! OuterComponent()
            .withOverrides(overrideModule: OuterComponent_Overrides()).build()
        
        XCTAssertEqual(root.foo.value, "Overridden_FOO")
        XCTAssertEqual(root.a.a1.value, "A_1_overridden")
        XCTAssertEqual(root.a.a2.value, "A_2_overridden")
        XCTAssertEqual(root.b.b1.value, "B_1_overridden")
        XCTAssertEqual(root.b.b2.value, "B_2_overridden")
    }
    
    func testOverridesOverride() {
        let root = try! OuterComponent()
            .withOverrides(overrideModule: OuterComponent_Overrides())
            .withOverrides(overrideModule: OuterComponent_Overrides_Overrides())
            .build()
        
        XCTAssertEqual(root.foo.value, "Super_Overridden_FOO")
        XCTAssertEqual(root.a.a1.value, "A_1_overridden_overridden")
        XCTAssertEqual(root.a.a2.value, "A_2_overridden")
        XCTAssertEqual(root.b.b1.value, "B_1_overridden")
        XCTAssertEqual(root.b.b2.value, "B_2_overridden")
    }
    
    /// Makes sure we can visit all the nodes
    func testVisitingOverridesOverrides() {
        NoopVisitor()
            .install(module: OuterComponent()
                .withOverrides(overrideModule: OuterComponent_Overrides())
                .withOverrides(overrideModule: OuterComponent_Overrides_Overrides())
        )
    }
    
    // MARK: Test data
    
    struct A_1 {
        let value: String
    }
    struct A_2 {
        let value: String
    }
    struct B_1 {
        let value: String
    }
    struct B_2 {
        let value: String
    }
    
    struct Foo {
        let value: String
    }
    
    struct Root {
        let a: A
        let b: B
        
        let foo: Foo
        
        struct A {
            let a1: A_1
            let a2: A_2
        }
        
        struct B {
            let b1: B_1
            let b2: B_2
        }
    }

    // MARK: Components
    
    struct OuterComponent : Component {
        typealias Root = OverrideComponentTests.Root
        
        func configure<B : Binder>(binder binder: B) {
            binder.bind().to(factory: Root.init)
            
            binder.bind().to(value: Foo(value: "foooo!"))
            
            binder.bindComponent().to(factory: Component_A.init)
            binder.bindComponent().to(factory: Component_B.init)
        }
    }
    
    struct Component_A : Component {
        typealias Root = OverrideComponentTests.Root.A
        
        func configure<B : Binder>(binder binder: B) {
            
            binder.bind().to(factory: Root.init)
            
            binder.bindComponent().to(factory: Component_A_1.init)
            binder.bindComponent().to(factory: Component_A_2.init)
        }
    }
    
    struct Component_A_1 : Component {
        typealias Root = A_1
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: A_1(value: "A_1"))
        }
    }
    
    struct Component_A_2 : Component {
        typealias Root = A_2
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: A_2(value: "A_2"))
        }
    }
    
    struct Component_B : Component {
        typealias Root = OverrideComponentTests.Root.B
        
        func configure<B : Binder>(binder binder: B) {
            
            binder.bind().to(factory: Root.init)
            
            binder
                .bindComponent()
                .to(factory: Component_B_1.init)
            
            binder
                .bindComponent()
                .to(factory: Component_B_2.init)
        }
    }
    
    struct Component_B_1 : Component {
        typealias Root = B_1
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: B_1(value: "B_1"))
        }
    }
    
    
    struct Component_B_2 : Component {
        typealias Root = B_2
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: B_2(value: "B_2"))
        }
    }
    
    // MARK: Component Overrides
    
    struct OuterComponent_Overrides : OverrideModule {
        typealias Overrides = OuterComponent
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: Foo(value: "Overridden_FOO"))
            
            binder.overrideComponent(withModule: Component_A_Overrides.self)
            binder.overrideComponent(withModule: Component_B_Overrides.self)
        }
    }
    
    struct Component_A_Overrides : OverrideModule {
        typealias Overrides = Component_A
        
        func configure<B : Binder>(binder binder: B) {
            binder.overrideComponent(withModule: Component_A_1_Overrides.self)
            binder.overrideComponent(withModule: Component_A_2_Overrides.self)
        }
    }
    
    struct Component_A_1_Overrides : OverrideModule {
        typealias Overrides = Component_A_1
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: A_1(value: "A_1_overridden"))
        }
    }
    
    struct Component_A_2_Overrides : OverrideModule {
        typealias Overrides = Component_A_2

        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: A_2(value: "A_2_overridden"))
        }
    }
    
    struct Component_B_Overrides : OverrideModule {
        typealias Overrides = Component_B

        func configure<B : Binder>(binder binder: B) {
            binder.overrideComponent(withModule: Component_B_1_Overrides.self)
            binder.overrideComponent(withModule: Component_B_2_Overrides.self)
        }
    }
    
    struct Component_B_1_Overrides : OverrideModule {
        typealias Overrides = Component_B_1

        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: B_1(value: "B_1_overridden"))
        }
    }
    
    struct Component_B_2_Overrides : OverrideModule {
        typealias Overrides = Component_B_2
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: B_2(value: "B_2_overridden"))
        }
    }
    
    // MARK: Component OverridesOverrides

    struct OuterComponent_Overrides_Overrides : OverrideModule {
        typealias Overrides = OverriddenComponent<OuterComponent, OuterComponent_Overrides>

        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: Foo(value: "Super_Overridden_FOO"))
            
            binder.overrideComponent(withModule: Component_A_Overrides_Overrides.self)
        }
    }
    
    struct Component_A_Overrides_Overrides : OverrideModule {
        typealias Overrides = OverriddenComponent<Component_A, Component_A_Overrides>

        func configure<B : Binder>(binder binder: B) {
            binder.overrideComponent(withModule: Component_A_1_Overrides_Overrides.self)
        }
    }
    
    struct Component_A_1_Overrides_Overrides : OverrideModule {
        typealias Overrides = OverriddenComponent<Component_A_1, Component_A_1_Overrides>
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind()
                .to(value: A_1(value: "A_1_overridden_overridden"))
        }
    }
}


