import Foundation

/// Full provider representation bound into object graph.
public struct StandardProvider: Equatable, Codable {
    public let type: String
    public let dependencies: [String]
    public let tag: String?
    public let scoped: String?
    public let collectionType: String?
    public let debugData: DebugData
    
    public init(type: String, dependencies: [String], tag: String?, scoped: String?, collectionType: String?, debugData: DebugData = .empty) {
        self.type = type
        self.dependencies = dependencies
        self.tag = tag
        self.scoped = scoped
        self.collectionType = collectionType
        self.debugData = debugData
    }
}

/// Partial provider presentation with known dependencies, but isn't bound into object graph yet.
/// In Cleanse this is usually a provider implementation created as a function.
public struct DanglingProvider: Equatable, Codable {
    public let type: String
    public let dependencies: [String]
    public let reference: String
    public let debugData: DebugData
    
    public init(type: String, dependencies: [String], reference: String, debugData: DebugData = .empty) {
        self.type = type
        self.dependencies = dependencies
        self.reference = reference
        self.debugData = debugData
    }
}

/// Provider bound into object graph, but referenced a dangling provider, thus its dependencies are unknown.
public struct ReferenceProvider: Equatable, Codable {
    public let type: String
    public let tag: String?
    public let scoped: String?
    public let collectionType: String?
    public let reference: String
    public let debugData: DebugData
    
    public init(type: String, tag: String?, scoped: String?, collectionType: String?, reference: String, debugData: DebugData = .empty) {
        self.type = type
        self.tag = tag
        self.scoped = scoped
        self.collectionType = collectionType
        self.reference = reference
        self.debugData = debugData
    }
}
