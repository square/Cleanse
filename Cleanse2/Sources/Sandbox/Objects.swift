                      
/*                     |   Array<Coffee>       |
 ---------------       |                       |
 |CoffeeCompany| --->  |   Array<Employee>     |
 ---------------       |                       |
                       |    CoffeeMaker        |  ---> Coffee
 */

import Foundation

struct Coffee: Equatable {
    let name: String
}


struct CoffeeMaker {
    let supportedCoffee: [Coffee]
    
    func canBrew(_ coffee: Coffee) -> Bool {
        return supportedCoffee.contains(where: { $0 == coffee })
    }
    
    func brew(_ coffee: Coffee) {
        if canBrew(coffee) {
            print("Brewing coffee: \(coffee.name)")
        }
    }
}

// ---------------------

struct Employee {
    let firstName: String
    let lastName: String
}

// ---------------------

struct CoffeeCompany {
    let coffeesOfTheDay: [Coffee]
    let coffeeMaker: CoffeeMaker
    let employees: [Employee]
    
    func openShop() {
        print("Our employees working today are:")
        employees.forEach { print($0.firstName, $0.lastName) }
        
        print("\nLet's start brewing our coffes of the day!\n")
        coffeesOfTheDay.forEach { (coffee) in
            if coffeeMaker.canBrew(coffee) {
                coffeeMaker.brew(coffee)
            } else {
                print("Our coffee maker doesn't know how to brew \(coffee.name) :(")
            }
        }
    }
}



