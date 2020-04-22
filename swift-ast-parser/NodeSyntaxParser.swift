//
//  NodeSyntaxParser.swift
//  cleansec-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/20/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

struct InputSanitizer {
    static func sanitize(text: String) -> [String] {
        return text
            .split(separator: "\n")
            .flatMap { element -> [String] in
                if let range = element.range(of: "(source_file") {
                    return [String(element.prefix(upTo: range.lowerBound)), String(element.suffix(from: range.lowerBound))]
                } else {
                    return [String(element)]
                }
            }
            .reversed()
            .flatMapScanPrevious { (previous, current) -> [String] in
                if !looksLikeValidOpening(text: current) {
                    return []
                } else {
                    guard let previous = previous else {
                        return [current]
                    }
                    if !looksLikeValidOpening(text: previous) {
                        let newCurrent = current + previous
                        return [newCurrent]
                    } else {
                        return [current]
                    }
                }
            }
            .reversed()
    }
    
    private static func looksLikeValidOpening(text: String) -> Bool {
        guard let firstSplit = text.split(separator: " ").first else {
            return false
        }
        let firstSplitString = String(firstSplit)
        if text.whitespaceIndentCount == 0 && firstSplitString.starts(with: "(source_file") {
            return true
        } else if firstSplitString.starts(with: "(") && firstSplitString.firstCapture(pattern: #"\((\w+)"#) != nil {
            return true
        } else {
            return false
        }
    }
}

extension Array {
    func flatMapScanPrevious<SegmentOfResult>(_ transform: (_ previous: Self.Element?, _ current: Self.Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence {
        try enumerated().flatMap { (arg) -> SegmentOfResult in
            let (offset, element) = arg
            var previous: Element? = nil
            if (offset - 1) >= startIndex {
               previous = self[offset - 1]
            }
            return try transform(previous, element)
        }
    }
}

struct ParseResult {
    let syntax: Syntax
    let endingIdx: Int
}

public struct NodeSyntaxParser {
    public static func parse(text: String) -> [Syntax] {
        let input = InputSanitizer.sanitize(text: text)
        var nodes: [Syntax] = []
        var idx = 0
        while idx < input.endIndex {
            let result = parse(from: input, at: idx)
            nodes += [result.syntax]
            idx = result.endingIdx
        }
        return nodes
    }
    
    private static func parse(from input: [String], at index: Int) -> ParseResult {
        precondition(index < input.endIndex && index >= input.startIndex)
        let node = input[index]
        precondition(node.trimmedLeadingWhitespace.first! == "(")
        let indentCount = node.whitespaceIndentCount
        var idx = index + 1
        var children: [Syntax] = []
        
        while idx < input.endIndex && input[idx].whitespaceIndentCount > indentCount {
            let result = parse(from: input, at: idx)
            children += [result.syntax]
            idx = result.endingIdx
        }
        
        let syntaxNode: Syntax
        if let id = node.identifier {
            syntaxNode = node.createNode(id: id, children: children)
        } else {
            syntaxNode = NodeSyntax(raw: node, children: children)
        }
        return ParseResult(syntax: syntaxNode, endingIdx: idx)
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
        guard let found = firstCapture(pattern: pattern) else {
            return nil
        }
        return NodeIdentifier(rawValue: found)
    }
}
