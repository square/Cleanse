import Foundation

/// Represents a raw syntax element in a source file.
public protocol Syntax {
    var raw: String { get }
    var children: [Syntax] { get }
}
