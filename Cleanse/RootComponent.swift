//
//  RootComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public protocol RootComponent : ComponentBase {
}

public extension ComponentFactoryProtocol where ComponentElement : RootComponent {
    static func of(_ componentType: ComponentElement.Type, validate: Bool = true, serviceLoader: CleanseServiceLoader = CleanseServiceLoader.instance) throws -> ComponentFactory<ComponentElement>  {

        if validate {
            let validator = ValidationVisitor()
            validator.install(dependency: ComponentElement.self)
            try validator.finalize(serviceLoader)
        }
        
        let graph = Graph(scope: nil)

        let p = graph.provider(ComponentFactory<ComponentElement>.self)

        graph.install(dependency: ComponentElement.self)
        
        try graph.finalize()

        return p.get()
    }
}
