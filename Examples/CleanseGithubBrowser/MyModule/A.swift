//
//  A.swift
//  MyModule
//
//  Created by Sebastian Edward Shanus on 4/26/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse
import UIKit

struct A {
    
}

struct B{}

public struct MyAModule: Cleanse.Module {
    public static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(A.self)
            .to { (b: B) -> A in
                return A()
        }
    }
    
    
}
