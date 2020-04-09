struct MyRoot_Factory {
	func build() -> WelcomeObject {
		return provideRoot
	}
}

extension MyRoot_Factory {
	var provideRoot: WelcomeObject {
		let provideCoffeeMachine_provider = provideCoffeeMachine
		let provideCoffeeBrand_provider = provideCoffeeBrand
		return RootModule.provideRoot(coffeeMaker:provideCoffeeMachine_provider, brand:provideCoffeeBrand_provider)
	}
	var newCoffeeArray: [Coffee] {
		return CoffeeModule.newCoffeeArray()
	}
	var provideCoffeeMachine: CoffeeMaker {
		let newCoffeeArray_provider = newCoffeeArray
		return CoffeeModule.provideCoffeeMachine(allCoffee:newCoffeeArray_provider)
	}
	var provideCoffeeBrand: CoffeeBrand {
		let provideCoffee_provider = provideCoffee
		return CoffeeModule.provideCoffeeBrand(philzCoffee:provideCoffee_provider)
	}
	var provideCoffee: Coffee {
		return CoffeeModule.provideCoffee()
	}
}

