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
        let userService = try! ComponentFactory.of(UserServiceComponent<DevelopmentUserServiceModule>.self).build()

        XCTAssertEqual(userService.getNameForUser(userID: "user-1"), "Development User One")
    }

    func testProductionComponent() {
        let userService = try! ComponentFactory.of(UserServiceComponent<ProductionUserServiceModule>.self).build()
        XCTAssertEqual(userService.getNameForUser(userID: "user-1"), "User One")
    }
}

private struct UserServiceComponent<_UserServiceModule: UserServiceModule> : RootComponent {
    public typealias Root = UserService

    static func configure<B : Binder>(binder binder: B) {
        binder.install(module: _UserServiceModule.self)
    }

    private static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.configured(with: _UserServiceModule.configureUserService)
    }
}

private protocol UserServiceModule : Module {
    static func configureUserService(binder bind: ReceiptBinder<UserService>) -> BindingReceipt<UserService>
}

private protocol UserService {
    func getNameForUser(userID userID: String) -> String?
}

private struct ProductionUserService : UserService, Scoped {
    typealias Scope = Singleton

    func getNameForUser(userID userID: String) -> String? {
        switch userID {
        case "user-1": return "User One"
        case "user-2": return "User Two"
        default: return nil
        }
    }
}

private struct DevelopmentUserService : UserService, Scoped {
    typealias Scope = Singleton

    func getNameForUser(userID userID: String) -> String? {
        switch userID {
        case "user-1": return "Development User One"
        case "user-2": return "Development User Two"
        default: return nil
        }
    }
}


private struct ProductionUserServiceModule : UserServiceModule {
    private static func configure<B : Binder>(binder binder: B) {
        binder.bind().to(factory: ProductionUserService.init)
    }

    private static func configureUserService(binder bind: ReceiptBinder<UserService>) -> BindingReceipt<UserService> {
        return bind.to { $0 as ProductionUserService }
    }
}


private struct DevelopmentUserServiceModule : UserServiceModule {
    private static func configure<B : Binder>(binder binder: B) {
        binder.bind().to(factory: DevelopmentUserService.init)
    }

    private static func configureUserService(binder bind: ReceiptBinder<UserService>) -> BindingReceipt<UserService> {
        return bind.to { $0 as DevelopmentUserService }
    }
}


