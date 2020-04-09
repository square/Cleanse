struct MyRoot_Factory {
	func build() -> WelcomeObject {
		return provideRoot
	}
}

extension MyRoot_Factory {
	var newCoffeeArray: [Coffee] {
		return CoffeeModule.newCoffeeArray()
	}
	var provideCoffee: Coffee {
		return CoffeeModule.provideCoffee()
	}
	var provideCoffeeMachine: CoffeeMaker {
		let newCoffeeArray_provider = newCoffeeArray
		return CoffeeModule.provideCoffeeMachine(allCoffee:newCoffeeArray_provider)
	}
	var provideRoot: WelcomeObject {
		let provideCoffeeMachine_provider = provideCoffeeMachine
		let provideCoffeeBrand_provider = provideCoffeeBrand
		let newCountryOrigin_provider = newCountryOrigin
		return RootModule.provideRoot(coffeeMaker:provideCoffeeMachine_provider, brand:provideCoffeeBrand_provider, countryOrigin:newCountryOrigin_provider)
	}
	var provideCoffeeBrand: CoffeeBrand {
		let provideCoffee_provider = provideCoffee
		return CoffeeModule.provideCoffeeBrand(philzCoffee:provideCoffee_provider)
	}
	var newCountryOrigin: CountryOrigin {
		return RootModule.newCountryOrigin()
	}
}

