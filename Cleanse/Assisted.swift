//
//  Assisted.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 9/5/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

public struct Assisted<E> : ProviderProtocol {
    public typealias Element = E
    
    let getter: () -> Element
    public init(getter: @escaping () -> E) {
        self.getter = getter
    }
    
    public func get() -> E {
        return getter()
    }
}
