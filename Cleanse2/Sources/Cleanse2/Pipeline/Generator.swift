//
//  Generator.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

public struct Generator {
    let resolvedComponents: [ResolvedComponent]
    init(resolvedComponents: [ResolvedComponent]) {
        self.resolvedComponents = resolvedComponents
    }
    
    mutating func finalize<O:TextOutputStream>(write output: inout O) throws {
        resolvedComponents.forEach { (component) in
            component.structDecl.withTrailingTrivia(.newlines(2)).write(to: &output)
            component.extensionSyntax.withTrailingTrivia(.newlines(2)).write(to: &output)
        }
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
                        pattern: info.variableProviderTypeIdentifier.withTrailingTrivia(.spaces(1)),
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
                name: info.variableNameTokenSyntax,
                declNameArguments: nil)
        } else {
            return SyntaxFactory.makeIdentifierExpr(
                identifier: info.variableNameTokenSyntax,
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


extension ResolvedProvider {
    var variableImplDeclSyntax: VariableDeclSyntax {
        SyntaxFactory.makeVariableDecl(
            attributes: nil,
            modifiers: nil,
            letOrVarKeyword: SyntaxFactory.makeVarKeyword().withTrailingTrivia(.spaces(1)),
            bindings: SyntaxFactory.makePatternBindingList([
                SyntaxFactory.makePatternBinding(
                    pattern: info.variableTypeIdentifier,
                    typeAnnotation: SyntaxFactory.makeTypeAnnotation(
                        colon: SyntaxFactory.makeColonToken().withTrailingTrivia(.spaces(1)),
                        type: SyntaxFactory.makeTypeIdentifier(type.text)).withTrailingTrivia(.spaces(1)),
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
                    calledExpression: SyntaxFactory.makeMemberAccessExpr(
                        base: SyntaxFactory.makeIdentifierExpr(
                            identifier: info.owningMobileTokenSyntax,
                            declNameArguments: nil),
                        dot: SyntaxFactory.makePeriodToken(),
                        name: info.declSyntax.identifier,
                        declNameArguments: nil),
                    leftParen: SyntaxFactory.makeLeftParenToken(),
                    argumentList: CallingFunctionFactory.make(declSyntax: info.declSyntax, parameters: resolvedDependencies.map { $0.info.variableProviderTypeTokenSyntax }),
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

extension ProviderInfo {
    var owningMobileTokenSyntax: TokenSyntax {
        SyntaxFactory.makeIdentifier(owningModule)
    }
    
    var variableNameTokenSyntax: TokenSyntax {
        return declSyntax.identifier
    }
    
    var variableProviderTypeTokenSyntax: TokenSyntax {
        SyntaxFactory.makeIdentifier("\(declSyntax.identifier.text)_provider")
    }
    
    var variableTypeIdentifier: IdentifierPatternSyntax {
        SyntaxFactory.makeIdentifierPattern(
            identifier: declSyntax.identifier
        )
    }
    
    var variableProviderTypeIdentifier: IdentifierPatternSyntax {
        SyntaxFactory.makeIdentifierPattern(
            identifier: variableProviderTypeTokenSyntax
        )
    }
}

extension ResolvedComponent {
    var extensionSyntax: ExtensionDeclSyntax {
        let expressions = resolvedProviders
            .map { $0.variableImplDeclSyntax.withLeadingTrivia(.tabs(1)) }
            .map { SyntaxFactory.makeMemberDeclListItem(decl: $0, semicolon: nil) }
        
        return SyntaxFactory.makeExtensionDecl(
            attributes: nil,
            modifiers: nil,
            extensionKeyword: SyntaxFactory.makeExtensionKeyword().withTrailingTrivia(.spaces(1)),
            extendedType: SyntaxFactory.makeSimpleTypeIdentifier(
                name: structNameSyntax,
                genericArgumentClause: nil).withTrailingTrivia(.spaces(1)),
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeMemberDeclBlock(
                leftBrace: SyntaxFactory.makeLeftBraceToken().withTrailingTrivia(.newlines(1)),
                members: SyntaxFactory.makeMemberDeclList(expressions),
                rightBrace: SyntaxFactory.makeRightBraceToken().withTrailingTrivia(.newlines(1)))
            )
    }
    
    var structNameSyntax: TokenSyntax {
        let structName = "\(name)_Factory"
        return SyntaxFactory.makeIdentifier(structName)
    }
    
    var structDecl: StructDeclSyntax {
        SyntaxFactory.makeStructDecl(
            attributes: nil,
            modifiers: nil,
            structKeyword: SyntaxFactory.makeStructKeyword().withTrailingTrivia(.spaces(1)),
            identifier: structNameSyntax.withTrailingTrivia(.spaces(1)),
            genericParameterClause: nil,
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: memberDeclSyntax)
    }
    
    private var memberDeclSyntax: MemberDeclBlockSyntax {
        SyntaxFactory.makeMemberDeclBlock(
            leftBrace: SyntaxFactory.makeLeftBraceToken().withTrailingTrivia(.newlines(1)),
            members: memberDeclList.withTrailingTrivia(.newlines(1)).withLeadingTrivia(.tabs(1)),
            rightBrace: SyntaxFactory.makeRightBraceToken().withTrailingTrivia(.newlines(1)))
    }
    
    private var memberDeclList: MemberDeclListSyntax {
        var items: [MemberDeclListItemSyntax] = []
        if let parent = parent {
            let parentFactoryName = "\(parent)_Factory"
            items += [
                SyntaxFactory.makeMemberDeclListItem(
                    decl: SyntaxFactory.makeVariableDecl(
                    attributes: nil,
                    modifiers: nil,
                    letOrVarKeyword: SyntaxFactory.makeLetKeyword(),
                    bindings: SyntaxFactory.makePatternBindingList([
                        SyntaxFactory.makePatternBinding(
                            pattern: SyntaxFactory.makeIdentifierPattern(identifier: SyntaxFactory.makeIdentifier("parent")),
                            typeAnnotation: SyntaxFactory.makeTypeAnnotation(
                                colon: SyntaxFactory.makeColonToken(),
                                type: SyntaxFactory.makeSimpleTypeIdentifier(
                                    name: SyntaxFactory.makeIdentifier(parentFactoryName),
                                    genericArgumentClause: nil
                                )
                            ),
                            initializer: nil,
                            accessor: nil,
                            trailingComma: nil)
                    ])),
                    semicolon: nil)
            ]
        }
        
        // Create builder function for root
        items += [
            SyntaxFactory.makeMemberDeclListItem(
                decl: SyntaxFactory.makeFunctionDecl(
                    attributes: nil,
                    modifiers: nil,
                    funcKeyword: SyntaxFactory.makeFuncKeyword().withTrailingTrivia(.spaces(1)),
                    identifier: SyntaxFactory.makeIdentifier("build"),
                    genericParameterClause: nil,
                    signature: SyntaxFactory.makeFunctionSignature(
                        input: SyntaxFactory.makeParameterClause(
                            leftParen: SyntaxFactory.makeLeftParenToken(),
                            parameterList: SyntaxFactory.makeBlankFunctionParameterList(),
                            rightParen: SyntaxFactory.makeRightParenToken()).withTrailingTrivia(.spaces(1)),
                        throwsOrRethrowsKeyword: nil,
                        output: SyntaxFactory.makeReturnClause(
                            arrow: SyntaxFactory.makeArrowToken().withTrailingTrivia(.spaces(1)),
                            returnType: SyntaxFactory.makeTypeIdentifier(root.type.text)
                        )
                    ),
                    genericWhereClause: nil,
                    body: SyntaxFactory.makeCodeBlock(
                        leftBrace: SyntaxFactory.makeLeftBraceToken().withTrailingTrivia(.newlines(1)).withLeadingTrivia(.spaces(1)),
                        statements: SyntaxFactory.makeCodeBlockItemList([
                            SyntaxFactory.makeCodeBlockItem(
                                item: SyntaxFactory.makeReturnStmt(
                                    returnKeyword: SyntaxFactory.makeReturnKeyword().withTrailingTrivia(.spaces(1)),
                                    expression: SyntaxFactory.makeIdentifierExpr(
                                        identifier: root.info.variableNameTokenSyntax,
                                        declNameArguments: nil)
                                    ),
                                semicolon: nil,
                                errorTokens: nil)
                        ]).withTrailingTrivia(.newlines(1)).withLeadingTrivia(.tabs(2)),
                        rightBrace: SyntaxFactory.makeRightBraceToken().withTrailingTrivia(.newlines(1)).withLeadingTrivia(.tabs(1)))
                ),
                semicolon: nil
            )
            
        ]
        
        return SyntaxFactory.makeMemberDeclList(items)
    }
}
