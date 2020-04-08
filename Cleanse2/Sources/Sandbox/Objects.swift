//
//  Objects.swift
//  Sandbox
//
//  Created by Sebastian Edward Shanus on 4/8/20.
//

import Foundation

struct CoffeeMaker {
    let coffee: Coffee
    
    func brew() {
        print("I just brewed \(coffee.name)!")
    }
}

struct CoffeeBrand {
    let type: Coffee
}

struct Coffee {
    let name: String
}

struct WelcomeObject {
    let coffeeMaker: CoffeeMaker
    let coffeeBrand: CoffeeBrand
    
    func helloWorld() {
        coffeeMaker.brew()
        print("My Brand: \(coffeeBrand.type)")
    }
}
