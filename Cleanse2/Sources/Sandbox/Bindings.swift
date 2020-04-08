//
//  Bindings.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import CleanseCore


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
    
    static func provideCoffeeBrand(philzCoffee: Coffee) -> CoffeeBrand {
        return CoffeeBrand(type: philzCoffee)
    }
    
    static func provideCoffeeMachine(philzCoffee: Coffee) -> CoffeeMaker {
        return CoffeeMaker(coffee: philzCoffee)
    }
}


struct RootModule: Module {
    static func provideRoot(coffeeMaker: CoffeeMaker, brand: CoffeeBrand) -> WelcomeObject {
        return WelcomeObject(coffeeMaker: coffeeMaker, coffeeBrand: brand)
    }
}


