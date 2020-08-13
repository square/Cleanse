//
//  CustomScopeBinding.swift
//  Cleansec-Generate-Fixtures
//
//  Created by Sebastian Edward Shanus on 8/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import Cleanse

fileprivate struct CustomScope: Cleanse.Scope {}
fileprivate typealias ShortScope = Binder<CustomScope>
fileprivate struct CustomScopeModule: Cleanse.Module {
    static func configure(binder: Binder<CustomScope>) {
        binder.bind(Int.self).to(value: 3)
    }
}

fileprivate struct CustomScopeTypealiasModule: Cleanse.Module {
    static func configure(binder: ShortScope) {
        binder.bind(Int.self).to(value: 3)
    }
}
