//
//  Provider.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation
import SwiftSyntax

struct Provider: Equatable {
    let type: TypedKey
    let owningModule: TypedKey
    let declSyntax: FunctionDeclSyntax
    
    var dependencies: [TypedKey] {
        return declSyntax.signature.input.parameterList.compactMap { parameter -> TypedKey? in
            guard let dependency = parameter.type else {
                return nil
            }
            return TypedKey(syntax: dependency)
        }
    }
    
    static func make(from function: FunctionDeclSyntax, in module: TypedKey) -> Provider? {
        // Validations
        guard let output = function.signature.output else {
            return nil
        }
        
        let type = TypedKey(syntax: output.returnType)
        
        return Provider(type: type, owningModule: module, declSyntax: function)
    }
}
