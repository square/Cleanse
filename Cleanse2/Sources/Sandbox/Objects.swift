//
//  Objects.swift
//  Sandbox
//
//  Created by Sebastian Edward Shanus on 4/8/20.
//

import Foundation

struct CoffeeMaker {
    let coffeeBrands: [Coffee]
    
    func brew() {
        coffeeBrands.forEach { (coffee) in
            print("I just brewed \(coffee.name)!")
        }
    }
}

struct CoffeeBrand {
    let type: Coffee
}

struct Coffee {
    let name: String
}

struct CountryOrigin {
    let name: String
}

struct WelcomeObject {
    let coffeeMaker: CoffeeMaker
    let coffeeBrand: CoffeeBrand
    let countryOrigin: CountryOrigin
    
    
    func helloWorld() {
        coffeeMaker.brew()
        print("This coffee is from \(countryOrigin.name)")
    }
}
