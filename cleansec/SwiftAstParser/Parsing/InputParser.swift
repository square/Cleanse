//
//  InputParser.swift
//  SwiftAstParser
//
//  Created by Sebastian Edward Shanus on 5/7/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

struct InputParser {
    static func parse(lines: [String]) -> [Syntax] {
        return parse(text: lines)
    }
    
    private static func parse(text: [String]) -> [Syntax] {
        let sanitizedText = sanitize(lines: text)
        var nodes: [Syntax] = []
        var idx = 0
        while idx < sanitizedText.endIndex {
            let result = parse(from: sanitizedText, at: idx)
            nodes += [result.syntax]
            idx = result.idx
        }
        return nodes
    }
    
    private static func parse(from input: [String], at index: Int) -> (syntax: Syntax, idx: Int) {
        precondition(index < input.endIndex && index >= input.startIndex)
        let node = input[index]
        precondition(node.trimmedLeadingWhitespace.first! == "(")
        let indentCount = node.whitespaceIndentCount
        var idx = index + 1
        var children: [Syntax] = []
        
        while idx < input.endIndex && input[idx].whitespaceIndentCount > indentCount {
            let result = parse(from: input, at: idx)
            children += [result.syntax]
            idx = result.idx
        }
        
        let syntaxNode: Syntax
        if let id = node.identifier {
            syntaxNode = node.createNode(id: id, children: children)
        } else {
            syntaxNode = UnknownSyntax(raw: node, children: children)
        }
        return (syntaxNode, idx)
    }
    
    // dump-ast output has some irregularities that need to be sanitized.
    private static func sanitize(lines: [String]) -> [String] {
        return lines.flatMap { element -> [String] in
            if let range = element.range(of: "(source_file") {
                return [String(element.prefix(upTo: range.lowerBound)), String(element.suffix(from: range.lowerBound))]
            } else {
                return [String(element)]
            }
        }
        .filter { !$0.isEmpty }
        .flatMapScanPrevious { (prev, current) -> [String] in
            if current.isOnlyWhitespace {
                return []
            }
            
            guard let previous = prev else {
                return [current]
            }
            if previous.isOnlyWhitespace {
                return [previous + current]
            }
            return [current]
        }
        .reduce(into: [String]()) { (result, element) in
            if !element.isValidNewlineStart && result.count > 0 {
                result[result.endIndex - 1].append(contentsOf: element)
            } else if element.isValidNewlineStart {
                result.append(element)
            }
        }
    }
}

fileprivate extension Array {
    func flatMapScanPrevious<SegmentOfResult>(_ transform: (Element?, Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence {
        return try enumerated().flatMap { (arg) -> SegmentOfResult in
            let (offset, element) = arg
            if offset == 0 {
                return try transform(nil, element)
            } else {
                return try transform(self[offset - 1], element)
            }
        }
    }
}
