//
//  AllBindingsPlugin.swift
//  CleanseGithubBrowser
//
//  Created by Sebastian Edward Shanus on 4/23/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

struct AllBindingPlugin: CleanseBindingPlugin {
    
    func visit(root: ComponentBinding, errorReporter: CleanseErrorReporter) {
        var allComponents: [ComponentBinding] = [root]
        var providers: [Any.Type] = []
        while !allComponents.isEmpty {
            let top = allComponents.remove(at: 0)
            print("------------")
            print("Component: \(top.componentType)")
            top.providers.forEach { (key, values) in
                providers.append(key.type)
                print("\(key):")
                values.forEach { (info) in
                    print(String(repeating: " ", count: 2) + "\(info)")
                    print(String(repeating: " ", count: 4) + "-> \(info.requirements)")
                }
                print("\(values)")
            }
            allComponents.append(contentsOf: top.subcomponents)
        }
        
        print("Providers:\n")
        print(providers)
    }
    
}
