struct RootComponent_Factory {
	func build() -> CoffeeCompany {
		return newCoffeeCompany
	}
}

extension RootComponent_Factory {
	var newCoffeeMaker: CoffeeMaker {
		let allTheCoffee_provider = allTheCoffee
		return CoffeeModule.newCoffeeMaker(allCoffee:allTheCoffee_provider)
	}
	var provideEmployees: [Employee] {
		return CoffeeModule.provideEmployees()
	}
	var newCoffeeCompany: CoffeeCompany {
		let allTheCoffee_provider = allTheCoffee
		let newCoffeeMaker_provider = newCoffeeMaker
		let provideEmployees_provider = provideEmployees
		return CoffeeModule.newCoffeeCompany(coffees:allTheCoffee_provider, coffeeMaker:newCoffeeMaker_provider, employees:provideEmployees_provider)
	}
	var allTheCoffee: [Coffee] {
		return CoffeeModule.allTheCoffee()
	}
}

