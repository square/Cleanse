//
//  SubcomponentTests.swift
//  CleanseTests
//
//  Created by Sebastian Edward Shanus on 12/16/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation
import XCTest
import Cleanse

struct A {
    let b: Provider<B>
}

struct B {
    let subcomponent: ComponentFactory<SubComponent>
}

struct RootType {
    let a: A
}

struct Subroot {
    let name: String
}

struct AppRootComponent: RootComponent {
    static func configure(binder: Binder<Unscoped>) {
        binder.install(dependency: SubComponent.self)
        binder.bind(A.self).to(factory: A.init)
        binder.bind(B.self).to(factory: B.init)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<RootType>) -> BindingReceipt<RootType> {
        return bind.to(factory: RootType.init)
    }
    
    typealias Root = RootType
}

struct SubComponent: Component {
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(String.self)
            .to(value: "Hello")
    }
    
    static func configureRoot(binder bind: ReceiptBinder<Subroot>) -> BindingReceipt<Subroot> {
        return bind.to(factory: Subroot.init)
    }
    
    typealias Root = Subroot
}


class SubcomponentTests: XCTestCase {
    func testNestedSubcomponents() {
        let root = try! ComponentFactory.of(AppRootComponent.self).build(())
        let subcomponent = root.a.b.get().subcomponent.build(())
        XCTAssert(subcomponent.name == "Hello")
    }
}
