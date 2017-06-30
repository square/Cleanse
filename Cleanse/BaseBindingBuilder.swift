//
//  BaseBindingBuilder.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/9/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

public struct BaseBindingBuilder<Element, B: BinderBase> : BindingBuilder {
    public typealias FinalProvider = Provider<Element>
    public typealias Input = Element
    public typealias Binder = B
    public let binder: B
    public static func mapElement(input: Input) -> FinalProvider.Element {
        return input
    }
    
    public static var collectionMergeFunc: Optional<([FinalProvider.Element]) -> FinalProvider.Element> {
        return nil
    }
}
