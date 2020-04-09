//
//  Generator.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

extension Diagnostic {
    var syntaxDecl: DeclSyntax {
        switch type {
        case .error, .fatal:
            return SyntaxFactory.makePoundErrorDecl(
                poundError: SyntaxFactory.makePoundErrorKeyword(),
                leftParen: SyntaxFactory.makeLeftParenToken(),
                message: SyntaxFactory.makeStringLiteralExpr(description),
                rightParen: SyntaxFactory.makeRightParenToken()).withTrailingTrivia(.newlines(1))
        case .warning:
            return SyntaxFactory.makePoundWarningDecl(
                poundWarning: SyntaxFactory.makePoundWarningKeyword(),
                leftParen: SyntaxFactory.makeLeftParenToken(),
                message: SyntaxFactory.makeStringLiteralExpr(description),
                rightParen: SyntaxFactory.makeRightParenToken()).withTrailingTrivia(.newlines(1))
        }
        
    }
}

public struct Generator {
    let resolvedComponents: [ResolvedComponent]
    let diagnostics: [Diagnostic]
    init(resolvedComponents: [ResolvedComponent], diagnostics: [Diagnostic]) {
        self.resolvedComponents = resolvedComponents
        self.diagnostics = diagnostics
    }
    
    mutating func finalize<O:TextOutputStream>(write output: inout O) throws {
        if diagnostics.count > 0 {
            diagnostics.forEach { (dianostic) in
                dianostic.syntaxDecl.write(to: &output)
            }
        } else {
            resolvedComponents.forEach { (component) in
                component.structDecl.withTrailingTrivia(.newlines(2)).write(to: &output)
                component.extensionSyntax.withTrailingTrivia(.newlines(2)).write(to: &output)
            }
        }
    }
}

