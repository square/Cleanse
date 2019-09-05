//
//  AssistedInjectionSeedDecorator.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 9/5/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

public struct AssistedInjectionSeedDecorator<Binder: BinderBase, E, S: AssistedFactory> : AssistedInjectionBuilder {
    public typealias Binder = Binder
    public typealias Element = S.Element
    public typealias Tag = S
    
    public let binder: Binder
}
