//
//  SPITests.swift
//  CleanseTests
//
//  Created by Sebastian Edward Shanus on 11/18/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse
import XCTest

final class SPITests: XCTestCase {
    struct MyRoot {
        let name: String
    }
    
    struct MyRootComponent: RootComponent {
        typealias Root = MyRoot
        
        static func configure(binder: Binder<Unscoped>) {
            
        }
        
        static func configureRoot(binder bind: ReceiptBinder<SPITests.MyRoot>) -> BindingReceipt<SPITests.MyRoot> {
            return bind.to(factory: { MyRoot(name: "Caroline") })
        }
    }
    
    struct MyPlugin: CleanseBindingPlugin {
        let expectation: XCTestExpectation
        func visit(root: ComponentBinding, errorReporter: CleanseErrorReporter) {
            expectation.fulfill()
        }
    }
    
    func testPluginRuns() {
        let expectation = XCTestExpectation(description: "Plugin should run")
        let plugin = MyPlugin(expectation: expectation)
        let serviceLoader = CleanseServiceLoader([plugin])
        
        let _ = try! ComponentFactory.of(MyRootComponent.self, validate: true, serviceLoader: serviceLoader)
        wait(for: [expectation], timeout: 1.0)
    }
}
