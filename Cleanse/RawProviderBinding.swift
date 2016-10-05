//
//  ProviderRegistry.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// Constains information about what needs to be registered
public struct RawProviderBinding {
    let scope: Scope.Type?
    
    /// This is the provider. The key of this is what will be provided.
    let provider: AnyProvider

    /// Input is actually `[Element]` where `Element: Collection`
    let collectionMergeFunc: Optional<([Any]) -> Any>

    let sourceLocation: SourceLocation?
}


extension RawProviderBinding {
    var isCollectionProvider: Bool {
        return collectionMergeFunc != nil
    }
}
