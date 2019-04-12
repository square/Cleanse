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
}

func ==<L, R> (lhs: CombinedHashable<L, R>, rhs: CombinedHashable<L, R>) -> Bool {
    return lhs.l == rhs.l && lhs.r == rhs.r
}

