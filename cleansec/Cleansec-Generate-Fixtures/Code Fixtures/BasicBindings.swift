//
//  BasicBindings.swift
//  Cleansec-Generate-Fixtures
//
//  Created by Sebastian Edward Shanus on 7/8/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import Cleanse

fileprivate struct BasicBindingsModule: Cleanse.Module {
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(Int.self)
            .to { (floatFactory: () -> Float, boolFactory: @escaping () -> Bool, float2Factory:()->Float) in
                return 3
            }
    }
}
