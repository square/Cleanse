import Foundation

/**
 These are string helpers unique to the -dump-ast format output.
 */
extension String {
    var isValidNewlineStart: Bool {
        if matches(#"^\(source_file"#) {
            return true
        }
        if let _ = firstCapture(#"^\s+\((\w+)"#) {
            return true
        } else if matches(#"\s+\($"#) {
            return true
        } else {
            return false
        }
    }
    
    var isOnlyWhitespace: Bool {
        allSatisfy { $0.isWhitespace }
    }
}

extension String {
    var whitespaceIndentCount: Int {
        prefix { $0.isWhitespace }.count
    }
    
    var trimmedLeadingWhitespace: String {
        String(suffix(count - whitespaceIndentCount))
    }
    
    var identifier: NodeIdentifier? {
        let pattern = #"\((\w+)"#
        guard let found = firstCapture(pattern) else {
            return nil
        }
        return NodeIdentifier(rawValue: found)
    }
}
