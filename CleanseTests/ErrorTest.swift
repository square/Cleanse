//
//  ErrorTest.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/28/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


import XCTest

@testable import Cleanse



class ErrorTests: XCTestCase {

    struct PropertyInjectionWithMissingDependenciesComponent : RootComponent {
        typealias Root = PropertyInjector<ErrorTests>

        static func configure<B : Binder>(binder binder: B) {
            binder.install(module: ModuleWithMissingDependencies.self)
        }
    }
    
    var structWithDeps: StructWithDependencies!
    
    func testMissingProviders() {
/*
         error should look something like
 
 Missing provider of type TaggedProvider<FTag>
  -> requested at CleanseTests/ErrorTest.swift:67 (configure) as a requirement for StructWithDependencies
  -> requested at CleanseTests/ErrorTest.swift:68 (configure) as a requirement for StructWithDependencies2
error 1/3:
Missing provider of type TaggedProvider<ETag>
  -> requested at CleanseTests/ErrorTest.swift:67 (configure) as a requirement for StructWithDependencies
error 2/3:
Missing provider of type TaggedProvider<GTag>
  -> requested at CleanseTests/ErrorTest.swift:68 (configure) as a requirement for StructWithDependencies2
         
*/
        do {
            _ = try ComponentFactory.of(PropertyInjectionWithMissingDependenciesComponent)
            
            XCTFail("Should not succeed")
        } catch let e as MultiError {
            let message = e.description
            Assert(message, contains: "*** TaggedProvider<ETag> *** binding missing")
            Assert(message, contains: "*** TaggedProvider<FTag> *** binding missing")
            Assert(message, contains: "*** TaggedProvider<GTag> *** binding missing")
            Assert(message, contains: "*** CheeseBannana *** binding missing")
            Assert(message, contains: "required by StructWithDependencies at ")
            Assert(message, contains: "ErrorTest.swift:")
        } catch let e {
            XCTFail("Unexpected Error \(e)")
        }
        
    }
    
    struct ATag : Tag { typealias Element = String }
    struct BTag : Tag { typealias Element = String }
    struct CTag : Tag { typealias Element = String }
    struct DTag : Tag { typealias Element = String }
    struct ETag : Tag { typealias Element = String }
    struct FTag : Tag { typealias Element = String }
    struct GTag : Tag { typealias Element = String }

    
    struct StructWithDependencies {
        let a: TaggedProvider<ATag>
        let b: TaggedProvider<BTag>
        let c: TaggedProvider<CTag>
        // Following are missing
        let e: TaggedProvider<ETag>
        let f: TaggedProvider<FTag>
    }
    
    struct CheeseBannana {}
    
    struct StructWithDependencies2 {
        let a: TaggedProvider<ATag>
        let b: TaggedProvider<BTag>
        let c: TaggedProvider<CTag>
        // Following are missing
        let f: TaggedProvider<FTag>
        let g: TaggedProvider<GTag>

        let cb: CheeseBannana
    }
    
    struct ModuleWithMissingDependencies : Module {
        static func configure<B : Binder>(binder binder: B) {
            binder.bind().to(factory: StructWithDependencies.init)
            binder.bind().to(factory: StructWithDependencies2.init)
            
            binder.bind().tagged(with:  ATag.self).to(value: "AAA")
            binder.bind().tagged(with:  BTag.self).to(value: "BBB")
            binder.bind().tagged(with:  CTag.self).to(value: "CCC")
            
            binder
                .bindPropertyInjectionOf(ErrorTests.self)
                .to { (target: ErrorTests, arg1: StructWithDependencies) in
                    target.structWithDeps = arg1
                }
        }
    }
    
    // TODO: once cycle validation is added, add support for that
}

#if !swift(>=3)
    
    extension String {
        @warn_unused_result
        func contains(other: String) -> Bool {
            return self.containsString(other)
        }
    }
    
#endif
