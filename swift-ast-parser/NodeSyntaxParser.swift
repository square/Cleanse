//
//  NodeSyntaxParser.swift
//  cleansec-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/20/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct InputSanitizer {
    public static func split(data: Data) -> [String] {
        return data.withUnsafeBytes { bytes in
            return bytes
                .split(separator: UInt8(ascii: "\n"))
                .map { String(decoding: UnsafeRawBufferPointer(rebasing: $0), as: UTF8.self) }
        }
    }
    
    public static func split(text: String) -> [String] {
        return text.split(separator: "\n").map { String($0) }
    }
    
    public static func sanitize(text: [String]) -> [String] {
        var fixedText = text.flatMap { element -> [String] in
            if let range = element.range(of: "(source_file") {
                return [String(element.prefix(upTo: range.lowerBound)), String(element.suffix(from: range.lowerBound))]
            } else {
                return [String(element)]
            }
        }
        .filter { !$0.isEmpty }
        
        var lastGoodIdx = 0
        var idx = 0
        var sanitizedText: [String] = []
        sanitizedText.reserveCapacity(fixedText.endIndex)

        while idx < fixedText.endIndex {
            defer {
                idx += 1
                lastGoodIdx = sanitizedText.endIndex - 1
            }
            let element = fixedText[idx]
            if !looksLikeValidOpening(text: element) && lastGoodIdx > 0 {
                sanitizedText[lastGoodIdx].append(contentsOf: element)
            } else {
                sanitizedText.append(element)
            }
        }
        return sanitizedText
    }
    
    private static func looksLikeValidOpening(text: String) -> Bool {
        if text.contains(pattern: #"^\(source_file"#) {
            return true
        }
        if let _ = text.firstCapture(pattern: #"^\s+\((\w+)"#) {
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
    public static func parse(text: [String]) -> [Syntax] {
        var nodes: [Syntax] = []
        var idx = 0
        while idx < text.endIndex {
            let result = parse(from: text, at: idx)
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
