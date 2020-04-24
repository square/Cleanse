//
//  main.swift
//  cleansec-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/20/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser
import cleasec

func main() {
    let interface = Cleansec.analyze(text: sample_text, searchNodes: [])
    interface.components.forEach { (component) in
        print("COMPONENT: \(component.type)")
        print("--\nProviders")
        component.providers.forEach { (provider) in
            print("Provider: \(provider.type) -> \(provider.dependencies)")
        }
        print("--\nIncluded Modules")
        print(component.includedModules)
        print("--\nIncluded Subcomponents")
        print(component.subcomponents)
    }
    
    interface.modules.forEach { (module) in
        print("Module: \(module.type)")
        print("--\nProviders")
        module.providers.forEach { (provider) in
            print("Provider: \(provider.type) -> \(provider.dependencies)")
        }
        print("--\nIncluded Modules")
        print(module.includedModules)
        print("--\nIncluded Subcomponents")
        print(module.subcomponents)
    }
}

main()
