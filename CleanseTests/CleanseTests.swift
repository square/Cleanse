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
    case American
    case Cheddar
}

enum Roll {
    case Ciabatta
    case Kaiser
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
    static func configure<B : Binder>(binder binder: B) {
        binder.install(module: BurgerModule.self)
        
        binder.bind().to(factory: Grill.init)
    }
}

struct BaseURLTag : Tag {
    typealias Element = NSURL
}

/// Provides the base URL to the rest of the app
struct BaseURLModule : Module {
    static func configure<B : Binder>(binder binder: B) {
        binder
            .bind(NSURL.self)
            .tagged(with: BaseURLTag.self)
            .to(value: NSURL(string: "https://api.squareup.com")!)
    }
}

class SomethingThatDoesAnAPICall {
    let baseURL: NSURL
    init(baseURL: TaggedProvider<BaseURLTag>) {
        self.baseURL = baseURL.get()
    }
    
    struct Module : Cleanse.Module {
        static func configure<B : Binder>(binder binder: B) {
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
    
    static func configure<B : Binder>(binder binder: B) {
        // "install" the modules that create the component
        binder.install(module: BaseURLModule.self)
        binder.install(module: SomethingThatDoesAnAPICall.Module.self)
    }

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.to(factory: Root.init)
    }
}

struct BurgerModule : Module {
    static func configure<B : Binder>(binder binder: B) {
        binder.bind().to(factory: Burger.init)
        binder.bind().to { return Cheese.Cheddar }
        binder.bind().to { Roll.Ciabatta }
        
        var singletonCountTest = 1
        binder
            .bind(Int.self)
            .tagged(with:  SlicesOfCheese.self)
            .asSingleton()
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
    static func configure<B : Binder>(binder binder: B) {
    }

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.to(value: 3)
    }
}

class CleanseTests: XCTestCase {

    func test__Simplest() {
        let value = try! ComponentFactory.of(SimpleModule.self).build()
        XCTAssertEqual(value, 3)
    }
    
    func test_SimpleInject() {
        
        let binder = Graph(scope: Singleton.self)
        
        binder.install(module: GrillModule.self)
        
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
        static func configure<B : Binder>(binder binder: B) {
            
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

        static func configure<B : Binder>(binder binder: B) {
            binder.install(module: CollectionBuilderBindingModule.self)
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    func test_CollectionBuilderBinding() {
        let results = try! ComponentFactory.of(CollectionBuilderBindingTestComponent.self).build()
        XCTAssertEqual(results.taggedIntCollection1.get().sorted(), [1,2,3,8,9,10,11])
    }
}


#if !swift(>=3)
    
extension RangeReplaceableCollection where Generator.Element: Comparable {
    @warn_unused_result
    func sorted() -> [Self.Generator.Element] {
        return self.sort()
    }
}

#endif
