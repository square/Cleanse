/*:
 
 ## Coffee Maker Example.

 This is a the equivalent of [Dagger's coffee make example](https://github.com/google/dagger/tree/master/examples/simple/src/main/java/coffee)
 
 In this example we will assemble a `CoffeeMaker` which is composed of both a `Heater` and a `Pump`.
 
 This demonstrates basic use of dependency injection.
*/

import Cleanse

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
    func configure<B : Binder>(binder binder: B) {
        binder.bind(Pump.self).to(factory: Thermosiphon.init)
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
    func configure<B : Binder>(binder binder: B) {
        binder.install(module: PumpModule())
            
        binder.bind(Heater.self).asSingleton().to(factory: ElectricHeater.init)
    }
}


//: Our root object. It requires both `Heater` and `Pump` to be configured.
class CoffeeMaker {
    let heater: Provider<Heater>  // Create a possibly costly heater only when we use it.
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

//: A component defines what our root of our object graph is and the modules it depends on to construct the root object

struct CoffeeMakerComponent : Component {
    typealias Root = CoffeeMaker

    func configure<B : Binder>(binder binder: B) {
        binder.install(module: DripCoffeeModule())

        
        // Bind our root object
        binder.bind().to(factory: CoffeeMaker.init)
    }
}

//: One calls the `build()` method on an instance of a component. This method returns the Root object if successful

let coffeeMaker = try! CoffeeMakerComponent().build()

//: Now that we have our coffee maker, let's brew a cup of Joe!

coffeeMaker.brew()




