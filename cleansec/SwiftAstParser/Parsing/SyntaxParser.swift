import Foundation

public struct SyntaxParser {
    public static func parse(data: Data) -> [Syntax] {
        return InputParser.parse(lines: data.mapToLines(seperator: UInt8(ascii: "\n")))
    }
    
    public static func parse(text: String) -> [Syntax] {
        return InputParser.parse(lines: text.split(separator: "\n").map { String($0) })
    }
}
