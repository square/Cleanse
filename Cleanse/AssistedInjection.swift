//
//  AssistedInjection.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 9/5/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

extension BinderBase {
    public func bindFactory<Element>(_ class: Element.Type) -> AssistedInjectionBindingBuilder<Self, Element> {
        return AssistedInjectionBindingBuilder(binder: self)
    }
}

extension AssistedInjectionBuilder {
    @discardableResult public func to(file: StaticString=#file, line: Int=#line, function: StaticString=#function, factory: @escaping (Assisted<Tag.Seed>) -> Element) -> BindingReceipt<Factory<Tag>> {
        let binder = self.binder
        
        binder
            .bind(Factory<Tag>.self)
            .to(value: Factory<Tag> { seed in
                return factory(
                    Assisted<Tag.Seed> { seed }
                )
            },
                file: file,
                line: line,
                function: function)
        return BindingReceipt()
    }
}
