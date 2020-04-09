//
//  ResolvedComponent+SyntaxBuilder.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation
import SwiftSyntax

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
        let structName = "\(name.rawRepresentation)_Factory"
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
                            returnType: root.type.typeIdentifier
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
                                        identifier: root.info.variableNameToken,
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

