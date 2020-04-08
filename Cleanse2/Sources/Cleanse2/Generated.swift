struct MyRoot_Factory {
	func build() -> B {
		return providesB
	}
}

extension MyRoot_Factory {
	var providesNumber: Int {
		return MyModule.providesNumber()
	}
	var providesB: B {
		let newA_provider = newA
		let providesNumber_provider = providesNumber
		return MyModule.providesB(a:newA_provider, c:providesNumber_provider)
	}
	var providesString: String {
		return MyModule.providesString()
	}
	var newA: A {
		let providesString_provider = providesString
		return MyModule.newA(string:providesString_provider)
	}
}

