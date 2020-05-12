import Foundation

/**
 Core representations that will be used to represent a parsed Cleanse files.
 
 These will be passed onto the succeediing pipeline steps and should remain agnostic to the underlying parsing implementation.
 This would allow us to swap out parsing implementations in the future without affecting the rest of the pipeline.
 
 */

/// Representation of a swift module, or group of files.
public struct ModuleRepresentation: Codable {
    public let files: [FileRepresentation]
}

/// Representation of a parsed swift file.
public struct FileRepresentation: Codable {
    public let components: [Component]
    public let modules: [Module]
}

/// Cleanse `Component` representation.
public struct Component: Codable {
    public let type: String
    public let rootType: String
    public let providers: [StandardProvider]
    public let danglingProviders: [DanglingProvider]
    public let referenceProviders: [ReferenceProvider]
    public let seed: String
    public let includedModules: [String]
    public let subcomponents: [String]
    public let isRoot: Bool
}

/// Cleanse `Module` representation.
public struct Module: Codable {
    public let type: String
    public let providers: [StandardProvider]
    public let danglingProviders: [DanglingProvider]
    public let referenceProviders: [ReferenceProvider]
    public let includedModules: [String]
    public let subcomponents: [String]
}
