//
//  Lock.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/25/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


extension NSLock {
    func with<Element>(_ closure: @noescape () throws -> Element) rethrows -> Element {
        lock()
        defer { unlock() }
        
        return try closure()       
    }
}
