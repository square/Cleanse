//
//  Regex.swift
//  cleansec-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/20/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public extension String {
    func contains(pattern: String) -> Bool {
        do {
            let range = NSRange(startIndex..<endIndex, in: self)
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            guard let _ = regex.firstMatch(in: self, options: [], range: range) else {
                return false
            }
            return true
        } catch {
            print("Failed to formulate regex: \(error)")
            return false
        }
    }
    
    func firstCapture(pattern: String) -> String? {
        do {
            let range = NSRange(startIndex..<endIndex, in: self)
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            guard let result = regex.firstMatch(in: self, options: [], range: range), result.numberOfRanges == 2, let stringRange = Range(result.range(at: 1), in: self) else {
                return nil
            }
            return String(self[stringRange])
            
        } catch {
            print("Failed to formulate regex: \(error)")
            return nil
        }
    }
    
    func allCaptures(pattern: String) -> [String] {
        do {
            let range = NSRange(startIndex..<endIndex, in: self)
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let results = regex.matches(in: self, options: [], range: range)
            return results.compactMap { (r) -> String? in
                guard r.numberOfRanges == 2 else {
                    return nil
                }
                let stringRange = Range(r.range(at: 1), in: self)!
                return String(self[stringRange])
            }
        } catch {
            print("Failed to formulate regex: \(error)")
            return []
        }
    }
}
