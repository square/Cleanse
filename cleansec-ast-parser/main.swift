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
    let interface = Cleansec.analyze(text: sample_text)
    
    let rootComponents = interface.components.filter { $0.isRoot }
    rootComponents.forEach { (root) in
        let resolvedComponent = Resolver.resolve(rootComponent: root, in: interface)
        print(resolvedComponent)
    }
}

main()
