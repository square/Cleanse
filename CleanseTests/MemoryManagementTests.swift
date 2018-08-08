//
//  CycleTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


import XCTest

@testable import Cleanse

class MemoryManagementTests: XCTestCase {
    
    struct MemoryManagementTestsComponent : Cleanse.RootComponent {
        typealias Root = MemoryManagementTests.Root
        
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: Module.self)
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    struct Root {
        let single1: Single1
        let single2: Single2
        
        let ss: SingleStruct1
        let ssProvider: () -> SingleStruct1
        
        let collection: [SingleCollectionElement]
        let collectionProvider:  () -> [SingleCollectionElement]
    }
    
    class Single1 {
        var weakSingle2: WeakProvider<Single2>!
        
        init(weakSingle2: WeakProvider<Single2>) {
            self.weakSingle2 = weakSingle2
        }
    }
    
    struct SingleStruct1 {
        static var counter = 0
        
        let value: Int
        
        let single2: Single2
        
        init(single2: Single2) {
            type(of: self).counter += 1
            self.value = type(of: self).counter
            self.single2 = single2
        }
    }
    
    class Single2 {
        fileprivate let single1: Single1
        init(single1: Single1) {
            self.single1 = single1
        }
    }
    
    
    class SingleCollectionElement {
        let value: Int
        
        init(value: Int) {
            self.value = value
        }
    }

    struct Module : Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind().sharedInScope().to(factory: Single1.init)
            binder.bind().sharedInScope().to(factory: Single2.init)
            binder.bind().sharedInScope().to(factory: SingleStruct1.init)
            
            binder.bind().intoCollection().sharedInScope().to { SingleCollectionElement(value: 3) }
            binder.bind().intoCollection().sharedInScope().to { SingleCollectionElement(value: 4) }
            binder.bind().intoCollection().sharedInScope().to { SingleCollectionElement(value: 5) }
        }
    }
    
    func testReleasesSingleton() {
        weak var s1: Single1? = nil
        weak var s2: Single2? = nil
        
        autoreleasepool {
            let root = try! ComponentFactory.of(MemoryManagementTestsComponent.self).build(())
            s1 = root.single1
            s2 = root.single2
            
            XCTAssertNotNil(s1?.weakSingle2.get())
            XCTAssertNotNil(s2?.single1)
            
            let weaks2 = s1!.weakSingle2.get()!
            XCTAssertNotNil(weaks2)
            
            XCTAssertEqual(root.ssProvider().value, root.ss.value)
            XCTAssertEqual(root.ssProvider().value, root.ss.value)
            
            if let s2 = s2 {
                XCTAssertEqual(ObjectIdentifier(weaks2), ObjectIdentifier(s2))
            }
        }
        
        XCTAssertNil(s1, "Should be released")
        XCTAssertNil(s2, "Should be released")
    }
    
    
    
    func testReleasesSingletonStructs() {
        weak var s1: Single1? = nil
        weak var s2: Single2? = nil
        
        autoreleasepool {
            let root = try! ComponentFactory.of(MemoryManagementTestsComponent.self).build(())
            s1 = root.single1
            s2 = root.single2
            
            XCTAssertNotNil(s1?.weakSingle2.get())
            XCTAssertNotNil(s2?.single1)
            
            let weaks2 = s1!.weakSingle2.get()!
            XCTAssertNotNil(weaks2)
            
            if let s2 = s2 {
                XCTAssertEqual(ObjectIdentifier(weaks2), ObjectIdentifier(s2))
            }
        }
        
        XCTAssertNil(s1, "Should be released")
        XCTAssertNil(s2, "Should be released")
    }
    
    func testReleasesSingletonInCollection() {
        weak var s1: SingleCollectionElement? = nil
        weak var s2: SingleCollectionElement? = nil
        weak var s3: SingleCollectionElement? = nil
        
        weak var s1p: SingleCollectionElement? = nil
        weak var s2p: SingleCollectionElement? = nil
        weak var s3p: SingleCollectionElement? = nil
        
        autoreleasepool {
            let root = try! ComponentFactory.of(MemoryManagementTestsComponent.self).build(())

            let c = root.collection.sorted { $0.value < $1.value }
            
            s1 = c[0]
            s2 = c[1]
            s3 = c[2]
            
            let c2 = root.collectionProvider().sorted { $0.value < $1.value }
            
            s1p = c2[0]
            s2p = c2[1]
            s3p = c2[2]
            
            XCTAssertNotNil(s1)
            XCTAssertNotNil(s2)
            XCTAssertNotNil(s3)
            
            XCTAssertNotNil(s1p)
            XCTAssertNotNil(s2p)
            XCTAssertNotNil(s3p)
            
            XCTAssertTrue(s1 === s1p)
            XCTAssertTrue(s2 === s2p)
            XCTAssertTrue(s3 === s3p)
        }
        
        XCTAssertNil(s1, "Should be released")
        XCTAssertNil(s2, "Should be released")
        XCTAssertNil(s3, "Should be released")
        
        XCTAssertNil(s1p, "Should be released")
        XCTAssertNil(s2p, "Should be released")
        XCTAssertNil(s3p, "Should be released")
    }
}
