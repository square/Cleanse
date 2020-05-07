import Foundation

/**
 Parses the output from `swiftc -dump-ast` and emits its parsed `Syntax` nodes.
 */
public struct SyntaxParser {
    /**
     Parses data input and returns syntax nodes.
     - returns: List of `Syntax` nodes.
     - parameter data: Raw data.
     */
    public static func parse(data: Data) -> [Syntax] {
        return InputParser.parse(lines: data.mapToLines(seperator: UInt8(ascii: "\n")))
    }
    
    /**
    Parses text input and returns syntax nodes.
    - returns: List of `Syntax` nodes.
    - parameter text: Raw text.
    */
    public static func parse(text: String) -> [Syntax] {
        return InputParser.parse(lines: text.split(separator: "\n").map { String($0) })
    }
}
