//
//  Provider+SyntaxBuilder.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation
import SwiftSyntax

extension Provider {
    var callableExpression: MemberAccessExprSyntax {
        SyntaxFactory.makeMemberAccessExpr(
            base: SyntaxFactory.makeIdentifierExpr(
                identifier: owningModuleTokenSyntax,
                declNameArguments: nil),
            dot: SyntaxFactory.makePeriodToken(),
            name: declSyntax.identifier,
            declNameArguments: nil)
    }
    
    var variableNameToken: TokenSyntax {
        return declSyntax.identifier
    }
    
    var localVariableProviderNameToken: TokenSyntax {
        SyntaxFactory.makeIdentifier("\(declSyntax.identifier.text)_provider")
    }
    
    var variableNameIdentifierPattern: IdentifierPatternSyntax {
        SyntaxFactory.makeIdentifierPattern(
            identifier: declSyntax.identifier
        )
    }
    
    var localVariableProviderIdentifierPattern: IdentifierPatternSyntax {
        SyntaxFactory.makeIdentifierPattern(
            identifier: localVariableProviderNameToken
        )
    }
    
    private var owningModuleTokenSyntax: TokenSyntax {
        SyntaxFactory.makeIdentifier(owningModule.typeIdentifier.tokens.map { $0.text }.joined())
    }
}
