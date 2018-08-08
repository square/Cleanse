//
//  LegacyObjectGraphTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


import XCTest

@testable import Cleanse

#if SUPPORT_LEGACY_OBJECT_GRAPH

class LegacyObjectGraphTests: XCTestCase {
    struct String1 : Tag {
        typealias Element = String
    }
    struct String2 : Tag {
        typealias Element = String
    }
    struct String3 : Tag {
        typealias Element = String
    }
    
    
    @objc class FreeBeer : NSObject {
        var string1: String!
        var string2: String!
        
        func injectProperties(
            string1: TaggedProvider<String1
            >, string2: TaggedProvider<String2>) {
            self.string1 = string1.get()
            self.string2 = string2.get()
        }
    }
    
    @objc class MoreFreeBeer : FreeBeer {
        var string3: String!
        
        func injectPropertiesWithSuper(
            superInjector: PropertyInjector<FreeBeer>,
            string3: TaggedProvider<String3>
        ) {
            superInjector.injectProperties(into: self)
            self.string3 = string3.get()
        }
        
        func injectPropertiesWithSuper_OverridingString2WithString3(
            superInjector: PropertyInjector<FreeBeer>,
            string3: TaggedProvider<String3>
            ) {
            superInjector.injectProperties(into: self)
            
            self.string2 = string3.get()
            self.string3 = string3.get()
        }
    }
    
    @objc class Foo : NSObject {
        var string1: String
        
        init(string1: TaggedProvider<String1>) {
            self.string1 = string1.get()
        }
    }
    
    struct SimpleLegacyModule : Module {
        static func configure(binder: UnscopedBinder) {
            binder
                .bind()
                .tagged(with: String1.self)
                .to(value: "String 1")
            
            binder.bind().to(factory: Foo.init)
            
            binder
                .bind()
                .tagged(with: String2.self)
                .to(value: "String 2")
        }
    }

    struct PropertyInjectionLegacyModuleBase : Module {
        static func configure(binder: UnscopedBinder) {
            binder.include(module: SimpleLegacyModule.self)
            
            binder
                .bind()
                .tagged(with: String3.self)
                .to(value: "String 3")

            
            binder
                .bindPropertyInjectionOf(FreeBeer.self)
                .to(injector: FreeBeer.injectProperties)            
            
            binder
                .bind(FreeBeer.self)
                .to { (injector: PropertyInjector<FreeBeer>) in
                    let result = FreeBeer()
                    injector.injectProperties(into: result)
                    return result
                }
            
            binder
                .bind(MoreFreeBeer.self)
                .to { (injector: PropertyInjector<MoreFreeBeer>) in
                    let result = MoreFreeBeer()
                    injector.injectProperties(into: result)
                    return result
            }

        }
    }
    
    
    struct PropertyInjectionLegacyModule : Module {
        static func configure(binder: UnscopedBinder) {
            binder.include(module: PropertyInjectionLegacyModuleBase.self)
            
            binder
                .bindPropertyInjectionOf(MoreFreeBeer.self)
                .to(injector: MoreFreeBeer.injectPropertiesWithSuper)
        }
    }
    
    struct PropertyInjectionLegacyModuleOverridingString2 : Module {
        static func configure(binder: UnscopedBinder) {
            binder.include(module: PropertyInjectionLegacyModuleBase.self)
                        
            binder
                .bindPropertyInjectionOf(MoreFreeBeer.self)
                .to(injector: MoreFreeBeer.injectPropertiesWithSuper_OverridingString2WithString3)
        }
    }

    struct SimpleLegacyComponent : RootComponent {
        typealias Root = LegacyObjectGraph

        static func configure(binder: UnscopedBinder) {
            binder.include(module: SimpleLegacyModule.self)
        }
    }

    func testLegacyObjectGraph() {
        let objectGraph = try! ComponentFactory.of(SimpleLegacyComponent.self).build(())
        XCTAssertEqual(objectGraph.objectForClass(cls: NSString.self, withName: "String1") as! NSString as String, "String 1")
    }
    
    
    func testLegacyObjectGraph_Provider() {
        let objectGraph = try! ComponentFactory.of(SimpleLegacyComponent.self).build(())
        XCTAssertEqual((objectGraph.providerForClass(cls: Foo.self)() as! Foo).string1, "String 1")
    }


    struct PropertyInjectionComponent : RootComponent {
        typealias Root = LegacyObjectGraph

        static func configure(binder: UnscopedBinder) {
            binder.include(module: PropertyInjectionLegacyModule.self)
        }
    }
    

    func testLegacyObjectGraph_PropertyInjection() {
        let objectGraph = try! ComponentFactory.of(PropertyInjectionComponent.self).build(())

        let moreFreeBeer = MoreFreeBeer()
        objectGraph.injectPropertiesIntoObject(object: moreFreeBeer)
        
        XCTAssertEqual(moreFreeBeer.string1, "String 1")
        XCTAssertEqual(moreFreeBeer.string2, "String 2")
        
        XCTAssertEqual(moreFreeBeer.string3, "String 3")
    }
    
    func testLegacyObjectGraph_PropertyInjection_Injected() {
        let objectGraph = try! ComponentFactory.of(PropertyInjectionComponent.self).build(())

        let moreFreeBeer = objectGraph.objectForClass(cls: MoreFreeBeer.self) as! MoreFreeBeer
        
        XCTAssertEqual(moreFreeBeer.string1, "String 1")
        XCTAssertEqual(moreFreeBeer.string2, "String 2")
        XCTAssertEqual(moreFreeBeer.string3, "String 3")
    }


    struct PropertyInjectionLegacyComponentOverridingString2 : RootComponent {
        typealias Root = LegacyObjectGraph

        static func configure(binder: UnscopedBinder) {
            binder.include(module: PropertyInjectionLegacyModuleOverridingString2.self)
        }
    }
    func testLegacyObjectGraph_PropertyInjection_OverridingString2() {
        let objectGraph = try! ComponentFactory.of(PropertyInjectionLegacyComponentOverridingString2.self).build(())

        let moreFreeBeer = objectGraph.objectForClass(cls: MoreFreeBeer.self) as! MoreFreeBeer
        
        XCTAssertEqual(moreFreeBeer.string1, "String 1")
        XCTAssertEqual(moreFreeBeer.string2, "String 3")
        XCTAssertEqual(moreFreeBeer.string3, "String 3")
        
    }
}

#endif
