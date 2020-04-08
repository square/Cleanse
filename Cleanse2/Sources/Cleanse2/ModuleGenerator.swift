//
//  ModuleGenerator.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import SwiftSyntax

struct ProviderRepresentation {
    let type: String
    let owningModule: String
    let protocolDeclSyntax: VariableDeclSyntax
}

extension ProviderRepresentation {
    var implDeclSyntax: VariableDeclSyntax {
        let mappedBindings = protocolDeclSyntax.bindings.map { (bindingSyntax) in
            bindingSyntax.withAccessor(
                SyntaxFactory.makeCodeBlock(
                    leftBrace: SyntaxFactory.makeLeftBraceToken().withTrailingTrivia(.newlines(1)),
                    statements: SyntaxFactory.makeCodeBlockItemList([
                        SyntaxFactory.makeCodeBlockItem(
                            item: SyntaxFactory.makeReturnStmt(
                                returnKeyword: SyntaxFactory.makeReturnKeyword().withTrailingTrivia(.spaces(1)),
                                expression: SyntaxFactory.makeMemberAccessExpr(
                                    base: SyntaxFactory.makeIdentifierExpr(
                                        identifier: SyntaxFactory.makeIdentifier(owningModule),
                                        declNameArguments: nil),
                                    dot: SyntaxFactory.makePeriodToken(),
                                    // TODO: IS there a better way to do this member access?
                                    name: SyntaxFactory.makeIdentifier(bindingSyntax.pattern.tokens.map { $0.text }.joined()),
                                    declNameArguments: nil)),
                            semicolon: nil,
                            errorTokens: nil).withLeadingTrivia(.tabs(2)).withTrailingTrivia(.newlines(1))
                    ]),
                    rightBrace: SyntaxFactory.makeRightBraceToken().withTrailingTrivia(.newlines(1)).withLeadingTrivia(.tabs(1)))
            )
        }
        return protocolDeclSyntax.withBindings(SyntaxFactory.makePatternBindingList(mappedBindings))
    }
}

struct ModuleGenerator {
    let moduleName: String
    let providers: [ProviderRepresentation]
    
    private var generatedModuleName: String {
        "\(moduleName)_Generated"
    }
    
    var generatedProtocol: ProtocolDeclSyntax {
        let protocolMemberDeclList = providers.map { SyntaxFactory.makeMemberDeclListItem(decl: $0.protocolDeclSyntax, semicolon: nil) }
        return SyntaxFactory.makeProtocolDecl(
            attributes: nil,
            modifiers: nil,
            protocolKeyword: SyntaxFactory.makeProtocolKeyword(leadingTrivia: .zero, trailingTrivia: .spaces(1)),
            identifier: SyntaxFactory.makeIdentifier(generatedModuleName, leadingTrivia: .zero, trailingTrivia: .spaces(1)),
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeMemberDeclBlock(
                leftBrace: SyntaxFactory.makeLeftBraceToken(leadingTrivia: .zero, trailingTrivia: .newlines(1)),
                members: SyntaxFactory.makeMemberDeclList(protocolMemberDeclList.map { $0.withLeadingTrivia(.tabs(1)) }),
                rightBrace: SyntaxFactory.makeRightBraceToken())
        ).withTrailingTrivia(.newlines(2))
    }
    
    var generatedExtensions: ExtensionDeclSyntax {
        return SyntaxFactory.makeExtensionDecl(
            attributes: nil,
            modifiers: nil,
            extensionKeyword: SyntaxFactory.makeExtensionKeyword().withTrailingTrivia(.spaces(1)),
            extendedType: SyntaxFactory.makeTypeIdentifier(
                moduleName,
                leadingTrivia: .zero,
                trailingTrivia: .spaces(1)
            ),
            inheritanceClause: SyntaxFactory.makeTypeInheritanceClause(
                colon: SyntaxFactory.makeColonToken(leadingTrivia: .zero, trailingTrivia: .spaces(1)),
                inheritedTypeCollection: SyntaxFactory.makeInheritedTypeList([
                    SyntaxFactory.makeInheritedType(
                        typeName: SyntaxFactory.makeTypeIdentifier(
                            generatedModuleName,
                            leadingTrivia: .zero,
                            trailingTrivia: .spaces(1)),
                        trailingComma: nil)
                ])
            ),
            genericWhereClause: nil,
            members: SyntaxFactory.makeMemberDeclBlock(
                leftBrace: SyntaxFactory.makeLeftBraceToken(),
                members: SyntaxFactory.makeMemberDeclList([]),
                rightBrace: SyntaxFactory.makeRightBraceToken())
        ).withTrailingTrivia(.newlines(2))
    }
    
    var generatedExtensionImpl: ExtensionDeclSyntax {
        return SyntaxFactory.makeExtensionDecl(
            attributes: nil,
            modifiers: nil,
            extensionKeyword: SyntaxFactory.makeExtensionKeyword().withTrailingTrivia(.spaces(1)),
            extendedType: SyntaxFactory.makeTypeIdentifier(generatedModuleName, leadingTrivia: .zero, trailingTrivia: .spaces(1)),
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeMemberDeclBlock(
                leftBrace: SyntaxFactory.makeLeftBraceToken().withTrailingTrivia(.newlines(1)),
                members: SyntaxFactory.makeMemberDeclList(
                    providers.map { p in
                        SyntaxFactory.makeMemberDeclListItem(
                            decl: p.implDeclSyntax,
                            semicolon: nil
                        ).withLeadingTrivia(.tabs(1)).withTrailingTrivia(.newlines(1))
                    }
                ),
                rightBrace: SyntaxFactory.makeRightBraceToken().withTrailingTrivia(.newlines(1)))
        ).withTrailingTrivia(.newlines(2))
    }
    
    func write<S:TextOutputStream>(to output: inout S) {
        generatedProtocol.write(to: &output)
        generatedExtensionImpl.write(to: &output)
        generatedExtensions.write(to: &output)
    }
}
