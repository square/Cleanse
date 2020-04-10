//
//  Bindings.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import CleanseCore

struct RootComponent: Component {
    typealias Root = CoffeeCompany
    
    static var modules: [Module.Type] = [CoffeeModule.self]
}

struct CoffeeModule : Module {
    static func newCoffeeCompany(coffees: [Coffee], coffeeMaker: CoffeeMaker, employees: [Employee]) -> CoffeeCompany {
        return CoffeeCompany(
            coffeesOfTheDay: coffees,
            coffeeMaker: coffeeMaker,
            employees: employees)
    }

    static func allTheCoffee() -> [Coffee] {
        [
            Coffee(name: "Philz"),
            Coffee(name: "Lady Falcon"),
            Coffee(name: "Death Wish")
        ]
    }

    static func provideEmployees() -> [Employee] {
        [
            Employee(firstName: "Espresso", lastName: "Joe"),
            Employee(firstName: "Bob", lastName: "Barista")
        ]
    }

    static func newCoffeeMaker(allCoffee: [Coffee]) -> CoffeeMaker {
        CoffeeMaker(supportedCoffee: allCoffee)
    }
}


