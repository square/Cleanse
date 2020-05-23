//
//  LinkedMerging.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/21/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

extension LinkedModule {
    func merge(from other: LinkedModule) -> LinkedModule {
        LinkedModule(
            type: type,
            providers: providers + other.providers,
            includedModules: includedModules + other.includedModules,
            subcomponents: subcomponents + other.subcomponents
        )
    }
}

extension LinkedComponent {
    func merge(from other: LinkedComponent) -> LinkedComponent {
        LinkedComponent(
            type: type,
            rootType: rootType,
            providers: providers + other.providers,
            seed: seed,
            includedModules: includedModules + other.includedModules,
            subcomponents: subcomponents + other.subcomponents,
            isRoot: isRoot
        )
    }
}
