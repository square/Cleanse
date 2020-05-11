import Foundation

public struct RegexCapture {
    public let groups: [String]
}

public extension String {
    func matches(_ pattern: String) -> Bool {
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
    
    func capture(_ pattern: String) -> [RegexCapture] {
        do {
            let range = NSRange(startIndex..<endIndex, in: self)
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let results = regex.matches(in: self, options: [], range: range)
            return results.compactMap { r -> RegexCapture? in
                guard r.numberOfRanges > 1 else {
                    return nil
                }
                let captures = (1..<r.numberOfRanges).map { idx -> String in
                    let stringRange = Range(r.range(at: idx), in: self)!
                    return String(self[stringRange])
                }
                return RegexCapture(groups: captures)
            }
        } catch {
            print("Failed to formulate regex: \(error)")
            return []
        }
    }
    
    func firstCapture(_ pattern: String, in group: Int = 0) -> String? {
        guard let firstCapture = capture(pattern).first else {
            return nil
        }
        return firstCapture.groups.first
    }
    
    func allCaptures(_ pattern: String, in group: Int = 0) -> [String] {
        return capture(pattern).compactMap { $0.groups.object(at: group) }
    }
}

fileprivate extension Array {
    func object(at idx: Int) -> Element? {
        if idx < endIndex && idx >= startIndex {
            return self[idx]
        } else {
            return nil
        }
    }
}
