//
//  ResolvedProvider+SyntaxBuilder.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation
import SwiftSyntax

extension ResolvedProvider {
    var variableImplDeclSyntax: VariableDeclSyntax {
        SyntaxFactory.makeVariableDecl(
            attributes: nil,
            modifiers: nil,
            letOrVarKeyword: SyntaxFactory.makeVarKeyword().withTrailingTrivia(.spaces(1)),
            bindings: SyntaxFactory.makePatternBindingList([
                SyntaxFactory.makePatternBinding(
                    pattern: info.variableNameIdentifierPattern,
                    typeAnnotation: SyntaxFactory.makeTypeAnnotation(
                        colon: SyntaxFactory.makeColonToken().withTrailingTrivia(.spaces(1)),
                        type: type.typeIdentifier
                    ).withTrailingTrivia(.spaces(1)),
                    initializer: nil,
                    accessor: bodyImplSyntax,
                    trailingComma: nil)
            ])
        )
    }
    
    private var providerFunctionCallSyntax: CodeBlockItemSyntax {
        SyntaxFactory.makeCodeBlockItem(
            item: SyntaxFactory.makeReturnStmt(
                returnKeyword: SyntaxFactory.makeReturnKeyword().withTrailingTrivia(.spaces(1)),
                expression: SyntaxFactory.makeFunctionCallExpr(
                    calledExpression: info.callableExpression,
                    leftParen: SyntaxFactory.makeLeftParenToken(),
                    argumentList: CallingFunctionFactory.make(declSyntax: info.declSyntax, parameters: resolvedDependencies.map { $0.info.localVariableProviderNameToken }),
                    rightParen: SyntaxFactory.makeRightParenToken(),
                    trailingClosure: nil)),
            semicolon: nil,
            errorTokens: nil)
    }
    
    private var bodyImplSyntax: CodeBlockSyntax {
        let dependencyCodeBlockItems = resolvedDependencies.map { resolvedDependency in
            resolvedDependency.dependencyVariableDeclSyntax.withTrailingTrivia(.newlines(1)).withLeadingTrivia(.tabs(2))
        }
        let blockItems = dependencyCodeBlockItems + [providerFunctionCallSyntax.withTrailingTrivia(.newlines(1)).withLeadingTrivia(.tabs(2))]
        return SyntaxFactory.makeCodeBlock(
            leftBrace: SyntaxFactory.makeLeftBraceToken().withTrailingTrivia(.newlines(1)),
            statements: SyntaxFactory.makeCodeBlockItemList(blockItems),
            rightBrace: SyntaxFactory.makeRightBraceToken().withTrailingTrivia(.newlines(1)).withLeadingTrivia(.tabs(1))
        )
    }
}

extension ResolvedProviderDependency {
    var dependencyVariableDeclSyntax: CodeBlockItemSyntax {
        SyntaxFactory.makeCodeBlockItem(
            item: SyntaxFactory.makeVariableDecl(
                attributes: nil,
                modifiers: nil,
                letOrVarKeyword: SyntaxFactory.makeLetKeyword().withTrailingTrivia(.spaces(1)),
                bindings: SyntaxFactory.makePatternBindingList([
                    SyntaxFactory.makePatternBinding(
                        pattern: info.localVariableProviderIdentifierPattern.withTrailingTrivia(.spaces(1)),
                        typeAnnotation: nil,
                        initializer: SyntaxFactory.makeInitializerClause(
                            equal: SyntaxFactory.makeEqualToken().withTrailingTrivia(.spaces(1)),
                            value: dependencyAccessorExprSyntax),
                        accessor: nil,
                        trailingComma: nil)
                ])),
            semicolon: nil,
            errorTokens: nil)
    }
    
    private var dependencyAccessorExprSyntax: ExprSyntax {
        if let baseParentExpr = parentPrefixExpressionSyntax(depth: parentDepth) {
            return SyntaxFactory.makeMemberAccessExpr(
                base: baseParentExpr,
                dot: SyntaxFactory.makePeriodToken(),
                name: info.variableNameToken,
                declNameArguments: nil)
        } else {
            return SyntaxFactory.makeIdentifierExpr(
                identifier: info.variableNameToken,
                declNameArguments: nil
            )
        }
    }
    
    private func parentPrefixExpressionSyntax(depth: Int) -> ExprSyntax? {
        if depth == 0 {
            return nil
        } else if depth == 1 {
            return SyntaxFactory.makeIdentifierExpr(
                identifier: SyntaxFactory.makeIdentifier("parent"),
                declNameArguments: nil
            )
        } else {
            return SyntaxFactory.makeMemberAccessExpr(
                base: parentPrefixExpressionSyntax(depth: depth - 1),
                dot: SyntaxFactory.makePeriodToken(),
                name: SyntaxFactory.makeIdentifier("parent"),
                declNameArguments: nil
            )
        }
    }
}
