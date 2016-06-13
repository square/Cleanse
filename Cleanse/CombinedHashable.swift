//
//  CombinedHashable.swift
//  Appointments
//
//  Created by Mike Lewis on 2/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// Combines two hashable values. Useful for paths of hashable values
struct CombinedHashable<L: Hashable, R: Hashable> : Hashable {
    let l: L
    let r: R
    
    init(_ l: L, _ r: R) {
        self.l = l
        self.r = r
    }
    
    var hashValue: Int {
        var seed = UInt(bitPattern: l.hashValue)
        let rHashValue = UInt(bitPattern: r.hashValue)
        // magic number from http://www.boost.org/doc/libs/1_35_0/doc/html/boost/hash_combine_id241013.html
        seed ^= rHashValue &+ 0x9e3779b9 &+ (seed << 6) &+ (seed >> 2)
        return Int(bitPattern: seed)
    }
}

func ==<L, R> (lhs: CombinedHashable<L, R>, rhs: CombinedHashable<L, R>) -> Bool {
    return lhs.l == rhs.l && lhs.r == rhs.r
}

