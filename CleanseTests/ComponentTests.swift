//
//  ComponentTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


import XCTest

@testable import Cleanse


var counter = 0

/// Useful for singletons
func nextCount() -> Int {
    counter += 1
    return counter
}

class ComponentTests: XCTestCase {
    struct CountTag : Tag {
        typealias Element = Int
    }
    
    struct Root {
        let hamburger: Hamburger
        let hamburgerProvider: () -> Hamburger
        let spicyHamburger: TaggedProvider<SpicyTag>
        let hotDog: HotDog
        let hotDogProvider: () -> HotDog
    }
    
    struct OuterComponent : Cleanse.Component {
        typealias Root = ComponentTests.Root
        
        func configure<B : Binder>(binder binder: B) {
            binder.bind().to(factory: Root.init)

            binder
                .bindComponent(HamburgerComponent.self)  
                .to(factory: HamburgerComponent.init)
            

            // Bind a special variant of this that has the default topping of HotSauce
            binder
                .bindComponent()
                .tagged(with:  SpicyTag.self)
                .to { (countProvider: TaggedProvider<CountTag>, countProvider2: TaggedProvider<CountTag>) in
                    HamburgerComponent(defaultToppingProvider: .init(value: .HotSauce), countProvider: countProvider)
                }
            
            binder
                .bindComponent()
                .asSingleton()
                .to(factory: HotDogComponent.init)

            binder
                .bind()
                .to(value: Topping.Watermellon)
            
            binder
                .bind(Int.self)
                .tagged(with:  CountTag.self)
                .to(factory: nextCount)

            
        }
    }
    
    enum Topping {
        case Ham
        case Watermellon
        case HotSauce
    }
    
    
    struct SpicyTag : Tag {
        typealias Element = Hamburger
    }
    
    struct Hamburger {
        let topping: Topping
        let count: Int
        
        init(topping: Topping, count: TaggedProvider<CountTag>) {
            self.topping = topping
            self.count = count.get()
        }
    }
    
    
    struct HamburgerComponent : Cleanse.Component {
        typealias Root = Hamburger
        
        private let defaultToppingProvider: Provider<Topping>
        private let countProvider: TaggedProvider<CountTag>
        
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind(Int.self)
                .tagged(with:  CountTag.self)
                .to(provider: countProvider)
            
            binder
                .bind()
                .to(provider: defaultToppingProvider)
            
            let factory = Hamburger.init
            binder.bind(Hamburger.self).to(factory: Hamburger.init)
        }
    }
    
    struct HotDog {
        let count: Int
        init(count: TaggedProvider<CountTag>) {
            self.count = count.get()
        }

    }
    
    struct HotDogComponent : Cleanse.Component {
        typealias Root = HotDog
        
        private let countProvider: TaggedProvider<CountTag>
        
        func configure<B : Binder>(binder binder: B) {
            
            binder
                .bind(Int.self)
                .tagged(with:  CountTag.self)
                .to(provider: countProvider)
            
            binder.bind().to(factory: HotDog.init)
        }
    }

    func testComponents() {
        let root = try! OuterComponent().build()
        
        XCTAssertEqual(root.hamburger.topping, Topping.Watermellon)
        XCTAssertEqual(root.hamburgerProvider().topping, Topping.Watermellon)
        
        XCTAssertEqual(root.spicyHamburger.get().topping, Topping.HotSauce)

        XCTAssertNotEqual(root.hamburgerProvider().count, root.hamburger.count)
        
        XCTAssertEqual(root.hotDogProvider().count, root.hotDog.count)
    }
}

