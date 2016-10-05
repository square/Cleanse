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

        static func configure<B : Binder>(binder binder: B) {
            binder.install(dependency: Component1.self)
            binder.install(dependency: Component2.self)

            binder
                .bind(RR.self)
                .to(factory: RR.init)
        }
    }

    struct RR {
        let r1: R1
        let r2: R2
    }

    struct Component1 : Cleanse.Component {
        typealias Root = R1

        static func configure<B : Binder>(binder binder: B) {
            binder.bind().to(value: R1.init)
        }
    }

    struct Component2 : Cleanse.Component {
        typealias Root = R2

        static func configure<B : Binder>(binder binder: B) {
            binder.bind().to(value: R2.init)
        }
    }
    
    struct R1 {
    }
    
    struct R2 {
    }

    final class NoopVisitor : ComponentVisitor {
        var visitorState: VisitorState<NoopVisitor> = .init()
    }

    func testNoopComponentVisitor() {
        let v =
            NoopVisitor()
        v.install(dependency: RootComponent.self)
    }
    
}
