//
//  CycleTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/20/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


import XCTest

@testable import Cleanse

class CycleTests: XCTestCase {

    class AA {
        init(b: BB) {

        }
    }

    class BB {
        init(a: AA) {

        }
    }

    struct BadComponent : RootComponent {
        typealias Root = AA

        static func configure(binder: Binder<Singleton>) {
            binder.bind(BB.self).sharedInScope().to(factory: BB.init)
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    class AA_OK {
        init(b: BB_OK) {

        }
    }

    class BB_OK {
        init(a: WeakProvider<AA_OK>) {
        }
    }

    struct GoodComponent : RootComponent {
        typealias  Root = AA_OK

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }

        static func configure(binder: Binder<Singleton>) {
            binder.bind().sharedInScope().to(factory: BB_OK.init)
        }
    }

    func testCycleDetection() {
        do {
            _ = try ComponentFactory.of(BadComponent.self)
            XCTFail("Should not succeed")
        } catch let e as DependencyCycle {
            let message = e.description
            Assert(message, contains: "Dependency Cycle Detected")
            Assert(message, contains: "required by AA at CleanseTests/CycleTests.swift")
            Assert(message, contains: "required by BB at CleanseTests/CycleTests.swift")
        } catch let e {
            XCTFail("Unexpected Error \(e)")
        }
    }

    func testWeakCyclesOK() {
        _ = try! ComponentFactory.of(GoodComponent.self)
    }
}
