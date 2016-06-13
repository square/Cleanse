//
//  TaggedBindingBuilderDecorator.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Internal type used for binding. We decorate a provider with this to indicate if we're scoped or not
public struct TaggedBindingBuilderDecorator<Wrapped: BindingBuilder, Tag: Cleanse.Tag where Tag.Element == Wrapped.FinalProvider.Element> : BindingBuilderDecorator {
    public typealias FinalProvider = TaggedProvider<Tag>
    
    public let wrapped: Wrapped
    
    public init(wrapped: Wrapped) {
        self.wrapped = wrapped
    }
}