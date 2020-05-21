import Foundation

/**
 Core representations for parsed Cleanse files.
 
 These will be passed onto the succeeding pipeline steps and should remain agnostic to the underlying parsing implementation.
 This would allow us to swap out parsing implementations in the future without affecting the rest of the pipeline.
 
 */

/// Representation of a swift module, or group of files.
public struct ModuleRepresentation: Codable {
    public let files: [FileRepresentation]
    
    public init(files: [FileRepresentation]) {
        self.files = files
    }
}

/// Representation of a parsed swift file.
public struct FileRepresentation: Codable {
    public let components: [Component]
    public let modules: [Module]
    
    public init(components: [Component], modules: [Module]) {
        self.components = components
        self.modules = modules
    }
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
    
    public init(
        type: String,
        rootType: String,
        providers: [StandardProvider],
        danglingProviders: [DanglingProvider],
        referenceProviders: [ReferenceProvider],
        seed: String,
        includedModules: [String],
        subcomponents: [String],
        isRoot: Bool
    ) {
        self.type = type
        self.rootType = rootType
        self.providers = providers
        self.danglingProviders = danglingProviders
        self.referenceProviders = referenceProviders
        self.seed = seed
        self.includedModules = includedModules
        self.subcomponents = subcomponents
        self.isRoot = isRoot
    }
}

/// Cleanse `Module` representation.
public struct Module: Codable {
    public let type: String
    public let providers: [StandardProvider]
    public let danglingProviders: [DanglingProvider]
    public let referenceProviders: [ReferenceProvider]
    public let includedModules: [String]
    public let subcomponents: [String]
    
    public init(
        type: String,
        providers: [StandardProvider],
        danglingProviders: [DanglingProvider],
        referenceProviders: [ReferenceProvider],
        includedModules: [String],
        subcomponents: [String]
    ) {
        self.type = type
        self.providers = providers
        self.danglingProviders = danglingProviders
        self.referenceProviders = referenceProviders
        self.includedModules = includedModules
        self.subcomponents = subcomponents
    }
}
