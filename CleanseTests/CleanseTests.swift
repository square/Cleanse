//
//  CleanseTests.swift
//  CleanseTests
//
//  Created by Mike Lewis on 4/22/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import XCTest
@testable import Cleanse

enum Cheese {
    case american
    case cheddar
}

enum Roll {
    case ciabatta
    case kaiser
}

struct Burger {
    let burgerIndex: TaggedProvider<BurgerIndex>
    let cheese: Cheese
    let roll: Roll
    // Should be a singleton
    let slicesOfCheese: TaggedProvider<SlicesOfCheese>
}

struct Grill {
    let burgerProvider: () -> Burger
}

struct GrillModule : Module {
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: BurgerModule.self)
        
        binder.bind().to(factory: Grill.init)
    }
}

struct BaseURLTag : Tag {
    typealias Element = URL
}

/// Provides the base URL to the rest of the app
struct BaseURLModule : Module {
    static func configure(binder: UnscopedBinder) {
        binder
            .bind(URL.self)
            .tagged(with: BaseURLTag.self)
            .to(value: URL(string: "https://api.squareup.com")!)
    }
}

class SomethingThatDoesAnAPICall {
    let baseURL: URL
    init(baseURL: TaggedProvider<BaseURLTag>) {
        self.baseURL = baseURL.get()
    }
    
    struct Module : Cleanse.Module {
        static func configure(binder: UnscopedBinder) {
            binder
                .bind(SomethingThatDoesAnAPICall.self)
                .to(factory: SomethingThatDoesAnAPICall.init)
        }
    }
}


struct RootAPI {
    let somethingUsingTheAPI: SomethingThatDoesAnAPICall
}

struct APIComponent : RootComponent {
    typealias Root = RootAPI
    
    static func configure(binder: UnscopedBinder) {
        // "install" the modules that create the component
        binder.include(module: BaseURLModule.self)
        binder.include(module: SomethingThatDoesAnAPICall.Module.self)
    }

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.to(factory: Root.init)
    }
}

struct BurgerModule : Module {
    static func configure(binder: Binder<Singleton>) {
        binder.bind().to(factory: Burger.init)
        binder.bind().to { return Cheese.cheddar }
        binder.bind().to { Roll.ciabatta }
        
        var singletonCountTest = 1
        binder
            .bind(Int.self)
            .tagged(with:  SlicesOfCheese.self)
            .sharedInScope()
            .to {
                defer { singletonCountTest += 1 }
                return singletonCountTest
            }
    
        
        var burgerIndex = 0
        
        binder
            .bind(Int.self)
            .tagged(with:  BurgerIndex.self)
            .to {
                defer { burgerIndex += 1 }
                return burgerIndex
            }
    }
}

struct SlicesOfCheese : Tag {
    typealias Element = Int
}

struct BurgerIndex : Tag {
    typealias Element = Int
}

struct SimpleModule : RootComponent {
    typealias Root = Int
    static func configure(binder: UnscopedBinder) {
    }

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.to(value: 3)
    }
}

class CleanseTests: XCTestCase {

    func test__Simplest() {
        let value = try! ComponentFactory.of(SimpleModule.self).build(())
        XCTAssertEqual(value, 3)
    }
    
    func test_SimpleInject() {
        
        let binder = Graph(scope: Singleton.self)
        
        binder.include(module: GrillModule.self)
        
        let p = binder.provider(Grill.self)
        
        do {
            try binder.finalize()
        } catch let e {
            print("Error! \(e)")
        }
        
        XCTAssertEqual(p.get().burgerProvider().burgerIndex.get(), 0)
        
        XCTAssertEqual(p.get().burgerProvider().slicesOfCheese.get(), 1)
        XCTAssertEqual(p.get().burgerProvider().slicesOfCheese.get(), 1)
        
        XCTAssertEqual(p.get().burgerProvider().burgerIndex.get(), 1)
        XCTAssertEqual(p.get().burgerProvider().burgerIndex.get(), 2)
    }
    
    struct MyIntTag : Tag {
        typealias Element = [Int]
    }
    
    
    struct FunStruct {
        var i: Int
    }

    struct CollectionBuilderBindingModule : Module {
        static func configure(binder: UnscopedBinder) {
            
            binder
                .bind()
                .intoCollection()
                .tagged(with:  MyIntTag.self)
                .to(value: [1,2,3])
            
            binder
                .bind()
                .intoCollection()
                .tagged(with:  MyIntTag.self)
                .to(value: [8,9,10])
            
            binder
                .bind()
                .intoCollection()
                .tagged(with:  MyIntTag.self)
                .to(value: 11)

            binder
                .bind(FunStruct.self)
                .intoCollection()
                .to(value: [1,2,3].map { FunStruct(i: $0) })
            
            binder
                .bind(FunStruct.self)
                .intoCollection()
                .to(value: [9,10,11].map { FunStruct(i: $0) })
        }
    }
    
    struct ProviderResults {
        let taggedIntCollection1: TaggedProvider<MyIntTag>
    }

    struct CollectionBuilderBindingTestComponent : RootComponent {
        typealias Root = ProviderResults

        static func configure(binder: UnscopedBinder) {
            binder.include(module: CollectionBuilderBindingModule.self)
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    func test_CollectionBuilderBinding() {
        let results = try! ComponentFactory.of(CollectionBuilderBindingTestComponent.self).build(())
        XCTAssertEqual(results.taggedIntCollection1.get().sorted(), [1,2,3,8,9,10,11])
    }
}
