//
//  Swift3Compat.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/29/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// These are helpers to make it so we can use a swift-3 compatible API

#if !swift(>=3.0)
    extension Collection {
        /// Backwards-compatible swift 2.2 shim
        @warn_unused_result
        func enumerated() -> EnumeratedSequence<Self> {
            return self.enumerated()
        }
    }
    
    extension String {
        /// Backwards-compatible swift 2.2 shim
        @warn_unused_result
        func components(separatedBy separator: String) -> [String] {
            return self.components(separatedBy: separator)
        }
    }
    
    
    extension Sequence where Iterator.Element == String {
        
        /// Backwards-compatible swift 2.2 shim
        @warn_unused_result
        public func joined(separator: String) -> String {
            return self.joined(separator: separator)
        }
    }
    
//    extension String {
//        
//        /// Backwards-compatible swift 2.2 shim
//        init(repeating c: Character, count: Int) {
//            self = String(count: count, repeatedValue: c)
//        }
//    }
    
    extension Array {
        func reversed() -> ReverseRandomAccessCollection<Array> {
            return self.reversed()
        }
    }
    
    public typealias RangeReplaceableCollection = Swift.RangeReplaceableCollection
#endif
