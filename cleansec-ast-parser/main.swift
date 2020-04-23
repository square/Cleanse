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
    let files = Cleansec.analyze(text: sample_text, searchNodes: [])
    files.forEach { (rep) in
        print("----")
        if rep.components.count > 0 {
            print(rep.components)
        }
        if rep.modules.count > 0 {
            print(rep.modules)
        }
    }
}

main()
