//
//  Bindings.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation


struct A {
    var string: String
}

struct B {
    let a: A
    let c: Int
    init(a: A, c: Int) {
        self.a = a
        self.c = c
    }
    
    func helloWorld() {
        print(c, a.string)
    }
}

struct MyRoot: Component {
    static var modules: [Module.Type] {
        [
            MyModule.self,
        ]
    }
    
    typealias Root = B
}


struct MyModule: Module {
    static func newA(string: String) -> A {
        return A(string: string)
    }
    
    static func providesB(a: A, c: Int) -> B {
        return B(a: a, c: c)
    }
    
    static func providesNumber() -> Int {
        return 3
    }
    
    static func providesString() -> String {
        return "hello"
    }
}


