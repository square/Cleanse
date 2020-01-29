//
//  Factory.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 9/5/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

public struct Factory<Tag: AssistedFactory> {
    let factory: (Tag.Seed) -> Tag.Element
    public init(factory: @escaping (Tag.Seed) -> Tag.Element) {
        self.factory = factory
    }
    
    public func build(_ seed: Tag.Seed) -> Tag.Element {
        return factory(seed)
    }
}
