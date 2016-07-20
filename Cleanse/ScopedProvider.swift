//
//  ScopedProvider.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

private var weakProviderAssociatedObjectKey = 0

class ScopedProvider {
    private let rawProvider : AnyProvider

    private let lock = NSLock()

    private var cachedValue: Any?

    init(rawProvider: AnyProvider) {
        self.rawProvider = rawProvider
    }


    /// This retains self
    var wrappedProvider: AnyProvider {
        return rawProvider.dynamicType.makeNew(getter: self.provide)
    }

    private func provide() -> Any {
        // If we already have it we can avoid locking
        if let cachedValue = cachedValue {
            return cachedValue
        }

        return lock.with {
            if let cachedValue = cachedValue {
                return cachedValue
            }

            let newValue = rawProvider.getAny()

            self.cachedValue = newValue

            return newValue
        }
    }
}
