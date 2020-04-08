import Foundation
import SwiftSyntax

struct TypeVerifier: SyntaxVisitor {
    enum Types: String, CaseIterable {
        case module = "(Cleanse\\.)?Module"
        case component = "(Cleanse\\.)?Component"
        case none = ""
    }
    var cleanseType: Types = .none
    mutating func visitPost(_ node: InheritedTypeSyntax) {
        let inheritedString = node.typeName.tokens.map { $0.text }.joined()
        cleanseType = Types.allCases.first { (type) -> Bool in
            if case .none = type {
                return false
            }
            return inheritedString.matches(regex: type.rawValue)
        } ?? .none
    }
}

extension String {
    func matches(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            if let _ = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: utf16.count)) {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func captureFirst(regex: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            guard let match = regex
                .firstMatch(in: self, options: [], range: NSRange(location: 0, length: utf16.count)) else {
                    fatalError("Failed to find match.")
            }
            let range = match.range(at: 1)
            return String(self[Range(range, in: self)!])
        } catch {
            fatalError("Couldn't formulate regex")
        }
    }
    
    func captureMatches(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            return regex
                .matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
                .compactMap { capture in
                    guard capture.numberOfRanges == 2 else {
                        return nil
                    }
                    return capture.range(at: 1)
                }
                .map { String(self[Range($0, in: self)!]) }
        } catch {
            return []
        }
    }
}


