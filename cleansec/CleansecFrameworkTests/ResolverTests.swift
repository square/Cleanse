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
        XCTAssertEqual(resolvedComponents.first!.providersByType.count, 2)
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
        XCTAssertEqual(resolvedComponents.first!.providersByType["[A]"]!.count, 2)
        XCTAssertEqual(resolvedComponents.first!.providersByType["[[A]]"]!.count, 2)
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
        XCTAssertEqual(resolvedComponents.first!.diagnostics.first!, ResolutionError(type: .duplicateProvider(collectionProviders[1].mapToCanonical())))
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
        XCTAssertEqual(resolvedComponents.first!.diagnostics.first!, ResolutionError(type: .duplicateProvider(providers.first!.mapToCanonical())))
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
    
    func testFindsLazyProviderDependency() {
        let rootA = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let providerC = StandardProvider(type: "C", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let newProvider = StandardProvider(type: "MyViewController", dependencies: ["Provider<C>"], tag: nil, scoped: nil, collectionType: nil)
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
        XCTAssertNotNil(resolvedComponents.first!.providersByType["TaggedProvider<MyTag>"])
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
        XCTAssertEqual(resolved.first!.diagnostics.first!, ResolutionError(type: .cyclicalDependency(chain: ["DepA", "DepB", "DepA"])))
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
        XCTAssertEqual(resolved.first!.diagnostics.first!, ResolutionError(type: .cyclicalDependency(chain: ["DepA", "DepB", "DepC", "DepA"])))
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
        XCTAssertEqual(resolved.first!.diagnostics.first!, ResolutionError(type: .cyclicalDependency(chain: ["DepB", "DepC", "DepB"])))
        XCTAssertEqual(resolved.first!.diagnostics[1], ResolutionError(type: .cyclicalDependency(chain: ["DepD", "DepE", "DepD"])))
    }
}
