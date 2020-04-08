import Cleanse

struct MyModule: Module {
    @Provides(type: Int.self) static var number: Int = 3
    @Provides(type: A.self) static var a = A(number: number)
    @Provides(wrappedValue: 3, type: Int.self) static var number3: Int
    @Provides(type: Int.self) static var c: Int = 5
}
