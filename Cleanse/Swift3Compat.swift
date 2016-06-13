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
    extension CollectionType {
        /// Backwards-compatible swift 2.2 shim
        @warn_unused_result
        func enumerated() -> EnumerateSequence<Self> {
            return self.enumerate()
        }
    }
    
    extension String {
        /// Backwards-compatible swift 2.2 shim
        @warn_unused_result
        func components(separatedBy separator: String) -> [String] {
            return self.componentsSeparatedByString(separator)
        }
    }
    
    
    extension SequenceType where Generator.Element == String {
        
        /// Backwards-compatible swift 2.2 shim
        @warn_unused_result
        public func joined(separator separator: String) -> String {
            return self.joinWithSeparator(separator)
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
            return self.reverse()
        }
    }
    
    public typealias RangeReplaceableCollection = RangeReplaceableCollectionType
#endif
