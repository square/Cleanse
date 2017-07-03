/*:
 
 ## Coffee Maker Example.

 This is a the equivalent of [Dagger's coffee make example](https://github.com/google/dagger/tree/master/examples/simple/src/main/java/coffee)
 
 In this example we will assemble a `CoffeeMaker` which is composed of both a `Heater` and a `Pump`.
 
 This demonstrates basic use of dependency injection.
*/

import Cleanse

struct Singleton : Scope {
}

protocol Pump {
    func pump()
}

protocol Heater {
    func on()
    func off()
    var isHot: Bool { get }
}

class Thermosiphon : Pump {
    let heater: Heater
    
    init(heater: Heater) {
        self.heater = heater
    }
    
    func pump() {
        if heater.isHot {
            print("=> => pumping => =>")
        }
    }
}

//: Module that configures `Thermosiphon` to be our `Pump`
struct PumpModule : Module {
    static func configure(binder: UnscopedBinder) {
        binder
            .bind(Pump.self)
            .to(factory: Thermosiphon.init)
    }
}

class ElectricHeater : Heater {
    private var heating = false
    
    var isHot: Bool {
        return heating
    }
    
    func on() {
        print("~ ~ ~ Heating ~ ~ ~")
        heating = true
    }
    
    func off() {
        heating = false
    }
}

//: Module that configures `ElectricHeater` to be our `Heater`. It also has a dependency on `PumpModule`.
struct DripCoffeeModule : Module {
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: PumpModule.self)

        binder
            .bind(Heater.self)
            .sharedInScope()
            .to(factory: ElectricHeater.init)
    }
}

//: Our root object. It requires both `Heater` and `Pump` to be configured.
class CoffeeMaker {
    let heater: Provider<Heater>  // Create a possibly costly heater only when we need it.
    let pump: Pump
    
    init(heater: Provider<Heater>, pump: Pump) {
        self.pump = pump
        self.heater = heater
    }

    func brew() {
        heater.get().on();
        pump.pump();
        print(" [_]P coffee! [_]P ");
        heater.get().off();
    }
}

//: Now let's create the Component. A component defines what the root of our object graph is and the modules it depends on to construct that root object.
struct CoffeeMakerComponent : RootComponent {
    typealias Root = CoffeeMaker

    static func configureRoot(binder bind: ReceiptBinder<CoffeeMaker>) -> BindingReceipt<CoffeeMaker> {
        return bind.to(factory: CoffeeMaker.init)
    }

    static func configure(binder: Binder<Singleton>) {
        binder.include(module: DripCoffeeModule.self)
    }
}

//: Create a ComponentFactory from the Component you'd like to use. Then call the `build()` method on that instance, which returns the Component's `Root`.
let coffeeMaker = try! ComponentFactory.of(CoffeeMakerComponent.self).build()

//: Now that we have our coffee maker, let's brew a cup of Joe!
coffeeMaker.brew()
