//
//  TypedKey.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/9/20.
//

import Foundation
import SwiftSyntax

struct TypedKey: Hashable {
    private let normalizedType: String
    init(syntax: TypeSyntax) {
        self.normalizedType = syntax.tokens.map { $0.text }.joined()
    }
    
    var rawRepresentation: String {
        return normalizedType
    }
    
    var typeIdentifier: TypeSyntax {
        SyntaxFactory.makeTypeIdentifier(normalizedType)
    }
}
