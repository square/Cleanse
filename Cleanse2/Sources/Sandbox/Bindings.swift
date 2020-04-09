//
//  Bindings.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import CleanseCore

//struct NewModule: Module {
//    static func scopedCoffee() -> Coffee {
//        return Coffee(name: "New Brand")
//    }
//}
//struct Subcomponent: Component {
//    static var modules: [Module.Type] {
//        [NewModule.self]
//    }
//    
//    static var parent: ComponentBase.Type? = MyRoot.self
//    
//    typealias Root = Coffee
//    
//    
//}

struct MyRoot: Component {
    static var modules: [Module.Type] {
        [
            CoffeeModule.self,
            RootModule.self
        ]
    }
    
    typealias Root = WelcomeObject
}

struct CoffeeModule: Module {
    static func provideCoffee() -> Coffee {
        return Coffee(name: "Philz")
    }
    
    static func newCoffeeArray() -> [ Coffee ] {
        return [
            Coffee(name: "Philz"),
            Coffee(name: "Lady Falcon"),
            Coffee(name: "Death Wish"),
            Coffee(name: "Starbucks")
        ]
    }
    
    static func provideCoffeeBrand(philzCoffee: Coffee) -> CoffeeBrand {
        return CoffeeBrand(type: philzCoffee)
    }
    
    static func provideCoffeeMachine(allCoffee: [Coffee]) -> CoffeeMaker {
        return CoffeeMaker(coffeeBrands: allCoffee)
    }
}


struct RootModule: Module {
    static func provideRoot(coffeeMaker: CoffeeMaker, brand: CoffeeBrand, countryOrigin: CountryOrigin) -> WelcomeObject {
        return WelcomeObject(coffeeMaker: coffeeMaker, coffeeBrand: brand, countryOrigin: countryOrigin)
    }
    
    static func newCountryOrigin() -> CountryOrigin {
        return CountryOrigin(name: "USA")
    }
}


