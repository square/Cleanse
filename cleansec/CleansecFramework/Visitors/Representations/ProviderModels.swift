import Foundation

/// Full provider representation bound into object graph.
public struct StandardProvider: Equatable, Codable {
    public let type: String
    public let dependencies: [String]
    public let tag: String?
    public let scoped: String?
    public let collectionType: String?
    
    public init(type: String, dependencies: [String], tag: String?, scoped: String?, collectionType: String?) {
        self.type = type
        self.dependencies = dependencies
        self.tag = tag
        self.scoped = scoped
        self.collectionType = collectionType
    }
}

/// Partial provider presentation with known dependencies, but isn't bound into object graph yet.
/// In Cleanse this is usually a provider implementation created as a function.
public struct DanglingProvider: Equatable, Codable {
    public let type: String
    public let dependencies: [String]
    public let reference: String
}

/// Provider bound into object graph, but referenced a dangling provider, thus its dependencies are unknown.
public struct ReferenceProvider: Equatable, Codable {
    public let type: String
    public let tag: String?
    public let scoped: String?
    public let collectionType: String?
    public let reference: String
}
