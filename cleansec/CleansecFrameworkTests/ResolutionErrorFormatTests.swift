//
//  ResolutionErrorFormatTests.swift
//  CleansecFrameworkTests
//
//  Created by Sebastian Edward Shanus on 8/20/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import XCTest
@testable import CleansecFramework

final class ResolutionErrorFormatTests: XCTestCase {
    func testResolutionErrorWithSuggestion() {
        let message = """
    error: Missing Provider: 'B'
    Depended upon by: 'Provider<A>'
    note: Found in 'Pony'. Perhaps 'binder.include(module: Pony.self)'

    """
        let provider = CanonicalProvider(type: TypeKey(type: "A"), dependencies: [], isCollectionProvider: false, debugData: .empty)
        let error = ResolutionError(type: .missingProvider(dependency: TypeKey(type: "B"), dependedUpon: provider, suggestedModules: ["Pony"]))
        XCTAssertEqual(error.description, message)
    }
    
    func testResolutionError() {
        let message = """
    error: Missing Provider: 'B'
    Depended upon by: 'Provider<A>'

    """
        let provider = CanonicalProvider(type: TypeKey(type: "A"), dependencies: [], isCollectionProvider: false, debugData: .empty)
        let error = ResolutionError(type: .missingProvider(dependency: TypeKey(type: "B"), dependedUpon: provider))
        XCTAssertEqual(error.description, message)
    }
    
    func testResolutionErrorDebugData() {
        let message = """
    /Users/Superfile.swift:123: error: Missing Provider: 'B'
    Depended upon by: 'Provider<A>'

    """
        let provider = CanonicalProvider(type: TypeKey(type: "A"), dependencies: [], isCollectionProvider: false, debugData: .location("/Users/Superfile.swift:123"))
        let error = ResolutionError(type: .missingProvider(dependency: TypeKey(type: "B"), dependedUpon: provider))
        XCTAssertEqual(error.description, message)
    }
    
    func testMissingInstalledComponentError() {
        let message = """
    error: Missing installed Component: 'Subby'

    """
        let error = ResolutionError(type: .missingSubcomponent("Subby"))
        XCTAssertEqual(error.description, message)
    }
    
    func testMissingIncludedModuleError() {
        let message = """
    error: Missing included Module: 'Moddy'

    """
        let error = ResolutionError(type: .missingModule("Moddy"))
        XCTAssertEqual(error.description, message)
    }
    
    func testDuplicateProviderError() {
        let provider1 = StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil).mapToCanonical()
        let provider2 = CanonicalProvider(type: TypeKey(type: "A"), dependencies: [], isCollectionProvider: false, debugData: .location("Users/SuperFile.swift:123"))
        let message = """
    error: Duplicate binding for 'Provider<A>'
    Users/SuperFile.swift:123: note: 'Provider<A>' previously bound here.

    """
        let error = ResolutionError(type: .duplicateProvider([provider1, provider2]))
        XCTAssertEqual(error.description, message)
    }
}
