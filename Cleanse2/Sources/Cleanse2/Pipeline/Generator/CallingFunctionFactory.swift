//
//  CallingFunctionFactory.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation
import SwiftSyntax

struct CallingFunctionFactory {
    static func make(declSyntax: FunctionDeclSyntax, parameters: [TokenSyntax]) -> FunctionCallArgumentListSyntax {
        precondition(parameters.count == declSyntax.signature.input.parameterList.count, "Mismatched parameter count")
        let functionCallArguments = declSyntax.signature.input.parameterList.enumerated().map { (idx, parameter) -> FunctionCallArgumentSyntax in
            let colon = parameter.firstName != nil ? SyntaxFactory.makeColonToken() : nil
            let trailingComma = (idx < parameters.count - 1) ? SyntaxFactory.makeCommaToken().withTrailingTrivia(.spaces(1)) : nil
            return SyntaxFactory.makeFunctionCallArgument(
                label: parameter.firstName,
                colon: colon,
                expression: SyntaxFactory.makeIdentifierExpr(
                    identifier: parameters[idx],
                    declNameArguments: nil),
                trailingComma: trailingComma)
        }
        return SyntaxFactory.makeFunctionCallArgumentList(functionCallArguments)
    }
}
