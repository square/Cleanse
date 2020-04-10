//
//  Resolved.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation

struct ResolvedProviderDependency {
    let parentDepth: Int
    let info: Provider
}

struct ResolvedProvider {
    let type: TypedKey
    let info: Provider
    let resolvedDependencies: [ResolvedProviderDependency]
}

struct ResolvedComponent {
    let name: TypedKey
    let resolvedProviders: [ResolvedProvider]
    let root: ResolvedProvider
    let parent: TypedKey?
    let subcomponents: [TypedKey]
}
