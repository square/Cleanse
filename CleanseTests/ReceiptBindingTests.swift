//
//  ReceiptBindingTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 1/6/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation
import XCTest

@testable import Cleanse


class ReceiptBindingTests: XCTestCase {
    func testDevelopmentComponent() {
        let userService = try! ComponentFactory.of(UserServiceComponent<DevelopmentUserServiceModule>.self).build(())

        XCTAssertEqual(userService.getNameForUser(userID: "user-1"), "Development User One")
    }

    func testProductionComponent() {
        let userService = try! ComponentFactory.of(UserServiceComponent<ProductionUserServiceModule>.self).build(())
        XCTAssertEqual(userService.getNameForUser(userID: "user-1"), "User One")
    }
}

private struct UserServiceComponent<_UserServiceModule: UserServiceModule> : RootComponent where _UserServiceModule.Scope == Singleton {
    fileprivate typealias Root = UserService

    static func configure(binder: Binder<Singleton>) {
        binder.include(module: _UserServiceModule.self)
    }

    fileprivate static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.configured(with: _UserServiceModule.configureUserService)
    }
}

private protocol UserServiceModule : Module {
    static func configureUserService(binder bind: ReceiptBinder<UserService>) -> BindingReceipt<UserService>
}

private protocol UserService {
    func getNameForUser(userID: String) -> String?
}

private struct ProductionUserService : UserService {
    typealias Scope = Singleton

    func getNameForUser(userID: String) -> String? {
        switch userID {
        case "user-1": return "User One"
        case "user-2": return "User Two"
        default: return nil
        }
    }
}

private struct DevelopmentUserService : UserService {
    func getNameForUser(userID: String) -> String? {
        switch userID {
        case "user-1": return "Development User One"
        case "user-2": return "Development User Two"
        default: return nil
        }
    }
}


private struct ProductionUserServiceModule : UserServiceModule {
    fileprivate static func configure(binder: Binder<Singleton>) {
        binder.bind().sharedInScope().to(factory: ProductionUserService.init)
    }

    fileprivate static func configureUserService(binder bind: ReceiptBinder<UserService>) -> BindingReceipt<UserService> {
        return bind.to { $0 as ProductionUserService }
    }
}


private struct DevelopmentUserServiceModule : UserServiceModule {
    fileprivate static func configure(binder: Binder<Singleton>) {
        binder.bind().sharedInScope().to(factory: DevelopmentUserService.init)
    }

    fileprivate static func configureUserService(binder bind: ReceiptBinder<UserService>) -> BindingReceipt<UserService> {
        return bind.to { $0 as DevelopmentUserService }
    }
}


