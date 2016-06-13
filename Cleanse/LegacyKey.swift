//
//  LegacyKey.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/27/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

#if SUPPORT_LEGACY_OBJECT_GRAPH

/// Similar to how we keyed stuff inside LegacyObjectGraph
struct LegacyKey : Hashable, DelegatedHashable {
    var cls: Any.Type
    var name: String?
    
    var hashable: CombinedHashable<ObjectIdentifier, String> {
        return CombinedHashable(.init(cls), name ?? "NIL")
    }
}

func ==(lhs: LegacyKey, rhs: LegacyKey) -> Bool {
    return lhs.cls == rhs.cls && lhs.name == rhs.name
}

#endif