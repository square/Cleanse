//
//  ComponentNode.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation

class ComponentNode: Hashable {
    static func == (lhs: ComponentNode, rhs: ComponentNode) -> Bool {
        lhs.name == rhs.name &&
            lhs.root == rhs.root &&
            lhs.parent == rhs.parent &&
            lhs.children == rhs.children &&
            lhs.providersInfoByType == rhs.providersInfoByType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let name: TypedKey
    let root: TypedKey
    weak var parent: ComponentNode?
    var children: [ComponentNode] = []
    var providersInfoByType: [TypedKey:Provider] = [:]
    
    init(name: TypedKey, root: TypedKey) {
        self.name = name
        self.root = root
    }
}
