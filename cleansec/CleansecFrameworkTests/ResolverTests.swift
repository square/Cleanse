//
//  ResolverTests.swift
//  CleansecFrameworkTests
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import Foundation
import XCTest
@testable import CleansecFramework

class ResolverTests: XCTestCase {
    func testResolvesOnlyRoots() {
        let component = LinkedComponent(type: "Nonroot", rootType: "A", providers: [], seed: "Void", includedModules: [], subcomponents: [], isRoot: false)
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 0)
    }
    
    func testCreatesCanonicalProviders() {
        let provider = StandardProvider(type: "MyClass", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let subcomponent = LinkedComponent(type: "Subcomponent", rootType: "Int", providers: [], seed: "Void", includedModules: [], subcomponents: [], isRoot: false)
        let module = LinkedModule(type: "AppModule", providers: [], includedModules: [], subcomponents: ["Subcomponent"])
        let component = LinkedComponent(type: "Root", rootType: "A", providers: [provider], seed: "Void", includedModules: ["AppModule"], subcomponents: [], isRoot: true)
        let interface = LinkedInterface(components: [subcomponent, component], modules: [module])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        let subcomponentFactory = resolvedComponents.first?.providersByType.keys.first { $0 == TypeKey(type: "ComponentFactory<Subcomponent>") }
        XCTAssertNotNil(subcomponentFactory)
    }
    
    func testResolvesSimpleRoot() {
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        // Providers for Seed
        XCTAssertEqual(resolvedComponents.first!.providersByType.count, 1)
    }
    
    func testCollectionBindingDuplicates() {
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let collectionProviders = [
            StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: "[A]"),
            StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: "[A]"),
            StandardProvider(type: "[A]", dependencies: [], tag: nil, scoped: nil, collectionType: "[[A]]"),
            StandardProvider(type: "[A]", dependencies: [], tag: nil, scoped: nil, collectionType: "[[A]]")
        ]
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: collectionProviders + [rootA],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 0)
        XCTAssertEqual(resolvedComponents.first!.providersByType[TypeKey(type: "[A]")]!.count, 2)
        XCTAssertEqual(resolvedComponents.first!.providersByType[TypeKey(type: "[[A]]")]!.count, 2)
    }
    
    func testInvalidCollectionBindings() {
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let collectionProviders = [
            StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: "[A]"),
            StandardProvider(type: "[A]", dependencies: [], tag: nil, scoped: nil, collectionType: nil),
        ]
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: collectionProviders + [rootA],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.first!, ResolutionError(type: .duplicateProvider(collectionProviders.map { $0.mapToCanonical() })))
    }
    
    func testDuplicateBinding() {
        let providers = [
            StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil),
            StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil),
        ]
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: providers,
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.first!, ResolutionError(type: .duplicateProvider(providers.map { $0.mapToCanonical() })))
    }
    
    func testDuplicateModuleIncludesIsOkay() {
        let providers = [
            StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil),
        ]
        let module = LinkedModule(type: "AModule", providers: providers, includedModules: [], subcomponents: [])
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [],
            seed: "Void",
            includedModules: ["AModule", "AModule"],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [module])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 0)
    }
    
    func testDuplicateInstalledSubcomponentsIsOkay() {
        let providers = [
            StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil),
        ]
        let rootB = StandardProvider(type: "B", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let subcomponents = LinkedComponent(
            type: "Sub", rootType: "B", providers: [rootB], seed: "Void", includedModules: [], subcomponents: [], isRoot: false)
        
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: providers,
            seed: "Void",
            includedModules: [],
            subcomponents: ["Sub", "Sub"],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component, subcomponents],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 0)
        XCTAssertEqual(resolvedComponents.first!.children.count, 1)
    }
    
    func testMissingModuleAndSubcomponents() {
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [rootA],
            seed: "Void",
            includedModules: ["A"],
            subcomponents: ["Sub"],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 2)
    }
    
    func testFindsDependencyFromAncestor() {
        let rootB = StandardProvider(type: "B", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let subcomponent = LinkedComponent(
            type: "Sub",
            rootType: "B",
            providers: [],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: false
        )
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [rootA, rootB],
            seed: "Void",
            includedModules: [],
            subcomponents: ["Sub"],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component, subcomponent],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        resolvedComponents.forEach { c in
            XCTAssertEqual(c.diagnostics.count, 0)
        }
    }
    
    func testMissingDependencyFromAncestor() {
        let subcomponent = LinkedComponent(
            type: "Sub",
            rootType: "B",
            providers: [],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: false
        )
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [rootA],
            seed: "Void",
            includedModules: [],
            subcomponents: ["Sub"],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component, subcomponent],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 1)
    }
    
    func testProviderMissingDependency() {
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let newProvider = StandardProvider(type: "MyViewController", dependencies: ["C"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [rootA,newProvider],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 1)
    }
    
    func testFindsLazyAndWeakProviderDependency() {
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let providerC = StandardProvider(type: "C", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let newProvider = StandardProvider(type: "MyViewController", dependencies: ["Provider<C>", "WeakProvider<C>"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [rootA,newProvider,providerC],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 0)
    }
    
    func testSubcomponentDependency() {
        let mySub = LinkedComponent(type: "MySub", rootType: "A", providers: [], seed: "Void", includedModules: [], subcomponents: [], isRoot: false)
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let newProvider = StandardProvider(type: "MyViewController", dependencies: ["ComponentFactory<MySub>"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [rootA,newProvider],
            seed: "Void",
            includedModules: [],
            subcomponents: ["MySub"],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component, mySub],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 0)
    }
    
    func testCanonicalMappings() {
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let newProvider = StandardProvider(type: "MyViewController", dependencies: [], tag: "MyTag", scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Nonroot",
            rootType: "A",
            providers: [rootA,newProvider],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(
            components: [component],
            modules: [])
        let resolvedComponents = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolvedComponents.count, 1)
        XCTAssertEqual(resolvedComponents.first!.diagnostics.count, 0)
        XCTAssertNotNil(resolvedComponents.first!.providersByType[TypeKey(type: "TaggedProvider<MyTag>")])
    }
    
    func testBasicCyclicalDependency() {
        let rootA = StandardProvider(type: "A", dependencies: ["DepA"], tag: nil, scoped: nil, collectionType: nil)
        let depA = StandardProvider(type: "DepA", dependencies: ["DepB"], tag: nil, scoped: nil, collectionType: nil)
        let depB = StandardProvider(type: "DepB", dependencies: ["DepA"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Root",
            rootType: "A",
            providers: [rootA,depA,depB],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(components: [component], modules: [])
        let resolved = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolved.count, 1)
        XCTAssertEqual(resolved.first!.diagnostics.first!, ResolutionError(type: .cyclicalDependency(chain: [TypeKey(type: "DepA"), TypeKey(type: "DepB"), TypeKey(type: "DepA")])))
    }
    
    func testThreeNCyclicalDependency() {
        let rootA = StandardProvider(type: "A", dependencies: ["DepA"], tag: nil, scoped: nil, collectionType: nil)
        let depA = StandardProvider(type: "DepA", dependencies: ["DepB"], tag: nil, scoped: nil, collectionType: nil)
        let depB = StandardProvider(type: "DepB", dependencies: ["DepC"], tag: nil, scoped: nil, collectionType: nil)
        let depC = StandardProvider(type: "DepC", dependencies: ["DepA"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Root",
            rootType: "A",
            providers: [rootA,depA,depB,depC],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(components: [component], modules: [])
        let resolved = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolved.count, 1)
        XCTAssertEqual(resolved.first!.diagnostics.first!, ResolutionError(type: .cyclicalDependency(chain: [TypeKey(type: "DepA"), TypeKey(type: "DepB"), TypeKey(type: "DepC"), TypeKey(type: "DepA")])))
    }
    
    func testMultipleCyclicalDependency() {
        let rootA = StandardProvider(type: "A", dependencies: ["DepA"], tag: nil, scoped: nil, collectionType: nil)
        let depA = StandardProvider(type: "DepA", dependencies: ["DepB", "DepD"], tag: nil, scoped: nil, collectionType: nil)
        let depB = StandardProvider(type: "DepB", dependencies: ["DepC"], tag: nil, scoped: nil, collectionType: nil)
        let depC = StandardProvider(type: "DepC", dependencies: ["DepB"], tag: nil, scoped: nil, collectionType: nil)
        let depD = StandardProvider(type: "DepD", dependencies: ["DepE"], tag: nil, scoped: nil, collectionType: nil)
        let depE = StandardProvider(type: "DepE", dependencies: ["DepD"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Root",
            rootType: "A",
            providers: [rootA,depA,depB,depC,depE,depD],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(components: [component], modules: [])
        let resolved = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolved.count, 1)
        XCTAssertEqual(resolved.first!.diagnostics.count, 2)
        XCTAssertEqual(resolved.first!.diagnostics.first!, ResolutionError(type: .cyclicalDependency(chain: [TypeKey(type: "DepB"), TypeKey(type: "DepC"), TypeKey(type: "DepB")])))
        XCTAssertEqual(resolved.first!.diagnostics[1], ResolutionError(type: .cyclicalDependency(chain: [TypeKey(type: "DepD"), TypeKey(type: "DepE"), TypeKey(type: "DepD")])))
    }
    
    func testResolvesTaggedProviders() {
        let rootA = StandardProvider(type: "TaggedProvider<A>", dependencies: ["DepA"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(
            type: "Root",
            rootType: "TaggedProvider<A>",
            providers: [rootA],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let interface = LinkedInterface(components: [component], modules: [])
        let resolved = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolved.count, 1)
        XCTAssertEqual(resolved.first!.diagnostics.count, 1)
        XCTAssertEqual(resolved.first!.diagnostics.first!, ResolutionError(type: .missingProvider(dependency: TypeKey(type: "DepA"), dependedUpon: rootA.mapToCanonical())))
    }
    
    func testSuggestedModules() {
        let providerA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let moduleA = LinkedModule(type: "AModule", providers: [providerA], includedModules: [], subcomponents: [])
        
        let providerB = StandardProvider(type: "B", dependencies: ["A"], tag: nil, scoped: nil, collectionType: nil)
        let component = LinkedComponent(type: "MyComponent", rootType: "B", providers: [providerB], seed: "Void", includedModules: [], subcomponents: [], isRoot: true)
        let interface = LinkedInterface(components: [component], modules: [moduleA])
        let resolved = Resolver.resolve(interface: interface)
        XCTAssertEqual(resolved.count, 1)
        XCTAssertEqual(resolved.first!.diagnostics, [ResolutionError(type: .missingProvider(dependency: TypeKey(type: "A"), dependedUpon: providerB.mapToCanonical(), suggestedModules: ["AModule"]))])
    }
}
