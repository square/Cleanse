//
//  WeakProvider.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/20/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

public struct WeakProvider<E> : ProviderProtocol {
    public typealias Element = E?

    fileprivate let getter: () -> Element

    public init(getter: @escaping () -> Element) {
        self.getter = getter
    }

    /// - returns: provides an instance of `Element`
    public func get() -> Element {
        return self.getter()
    }
}

protocol AnyWeakProvider : AnyProvider {
    static var standardProviderType: AnyProvider.Type { get }
}

extension WeakProvider : AnyProvider, AnyWeakProvider {
    static func makeNew(getter: @escaping () -> Any) -> AnyProvider {
        return WeakProvider(getter: {
            getter() as? E
        })
    }

    var anyGetterProvider: AnyProvider? {
        preconditionFailure("Should not get here")
    }

    static var standardProviderType: AnyProvider.Type {
        return Provider<E>.self
    }
}
