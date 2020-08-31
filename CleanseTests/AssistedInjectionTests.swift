//
//  AssistedInjectionTests.swift
//  CleanseTests
//
//  Created by Sebastian Edward Shanus on 9/5/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation
@testable import Cleanse
import XCTest

class AssistedInjectionTests: XCTestCase {
    struct AFactory: AssistedFactory {
        typealias Element = HelpNeeded
        typealias Seed = String
    }
    
    struct BFactory: AssistedFactory {
        typealias Element = MajorHelpNeeded
        typealias Seed = (Money, String, Int)
    }
    
    struct FreeServiceModule: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder
                .bind(FreeService.self)
                .to(factory: FreeService.init)
        }
    }
    
    struct FreeService {
        let weight = 1000
    }
    
    struct Money {
        let amount = 10
    }
    
    struct HelpNeeded {
        let name: Assisted<String>
    }
    
    struct MajorHelpNeeded {
        let freeService: FreeService
        let assistance: Assisted<(Money, String, Int)>
    }
    
    struct AssistedInjectionModule: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder
                .bindFactory(HelpNeeded.self)
                .with(AFactory.self)
                .to(factory: HelpNeeded.init)
            
            binder
                .bindFactory(MajorHelpNeeded.self)
                .with(BFactory.self)
                .to { (seed: Assisted<BFactory.Seed>, service: FreeService) in
                    return MajorHelpNeeded(freeService: service,
                                           assistance: seed)
                    
                }
        }
    }
    
    struct AssistedRoot {
        let helpFactory: Factory<AFactory>
        let majorHelpFactory: Factory<BFactory>
    }
    
    struct AssistedInjectionRoot: RootComponent {
        typealias Root = AssistedRoot
        
        static func configure(binder: Binder<Unscoped>) {
            binder.include(module: AssistedInjectionModule.self)
            binder.include(module: FreeServiceModule.self)
        }
        
        static func configureRoot(binder bind: ReceiptBinder<AssistedInjectionTests.AssistedRoot>) -> BindingReceipt<AssistedInjectionTests.AssistedRoot> {
            return bind.to(factory: AssistedRoot.init)
        }
        
    }
    
    struct AssistedInjectionBrokenRoot: RootComponent {
        typealias Root = AssistedRoot
        
        static func configure(binder: Binder<Unscoped>) {
            binder.include(module: AssistedInjectionModule.self)
        }
        
        static func configureRoot(binder bind: ReceiptBinder<AssistedInjectionTests.AssistedRoot>) -> BindingReceipt<AssistedInjectionTests.AssistedRoot> {
            return bind.to(factory: AssistedRoot.init)
        }
        
    }
    
    
    func testFactories() {
        let root = try! ComponentFactory.of(AssistedInjectionRoot.self).build(())
        let helpNeeded = root.helpFactory.build("Hello!")
        let majorHelpNeeded = root.majorHelpFactory.build((Money(), "Hello123", 123))
        
        XCTAssertEqual(helpNeeded.name.get(), "Hello!")
        
        let (money, name, amount) = majorHelpNeeded.assistance.get()
        XCTAssertEqual(money.amount, 10)
        XCTAssertEqual(name, "Hello123")
        XCTAssertEqual(amount, 123)
    }
    
    func testFactoryErrorMessage() {
        do {
            let _ = try ComponentFactory.of(AssistedInjectionBrokenRoot.self).build(())
            XCTAssertTrue(false, "Should throw an error")
        } catch {
            guard let error = error as? MissingProvider else {
                XCTAssertTrue(false, "Should be a missing provider error")
                return
            }
            XCTAssertNotNil(error.requests.first?.sourceLocation)
            XCTAssertTrue(error.requests.first!.sourceLocation!.description.contains("AssistedInjectionTests.swift"))
        }
    }
}
