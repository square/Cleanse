//
//  ScopedProvider.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

private var weakProviderAssociatedObjectKey = 0

class ScopedProvider {
    fileprivate let rawProvider : AnyProvider

    fileprivate let lock = NSLock()

    fileprivate var cachedValue: Any?

    init(rawProvider: AnyProvider) {
        self.rawProvider = rawProvider
    }


    /// This retains self
    var wrappedProvider: AnyProvider {
        return type(of: rawProvider).makeNew(getter: self.provide)
    }

    fileprivate func provide() -> Any {
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
