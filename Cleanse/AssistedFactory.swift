//
//  AssistedFactory.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 9/5/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

public protocol AssistedFactory: Tag {
    associatedtype Seed
}

public struct EmptySeed<E> : AssistedFactory {
    public typealias Seed = Void
    public typealias Element = E
}
