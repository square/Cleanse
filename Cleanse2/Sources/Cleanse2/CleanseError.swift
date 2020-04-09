//
//  CleanseError.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

enum DiagnosticType {
    case warning, error, fatal
}

enum DiagnosticScope {
    case singleton
    case component(TypedKey)
    case provider(TypedKey)
}

enum DianosticOption {
    case none
    case commentOut
}

struct Diagnostic: Error {
    let type: DiagnosticType
    let scope: DiagnosticScope
    let description: String
    var option: DianosticOption = .commentOut
}

struct CleanseError: Error {
}
