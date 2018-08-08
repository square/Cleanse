//
//  ComponentTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


import XCTest

@testable import Cleanse


private var counter = 0

/// Useful for singletons
private func nextCount() -> Int {
    counter += 1
    return counter
}


class ComponentTests: XCTestCase {

    func testSubcomponents() {
        let app = try! ComponentFactory.of(AppComponent.self).build(())

        let user1root1 = app.loggedInComponentFactory.build("user-1")
        let user1root2 = app.loggedInComponentFactory.build("user-1")
        let user2root1 = app.loggedInComponentFactory.build("user-2")

        XCTAssertEqual(user1root1.userProvider.get().name, "User One")
        XCTAssertEqual(user2root1.userProvider.get().name, "User Two")
        XCTAssertTrue(user1root1.userProvider.get() === user1root1.userProvider.get(), "The user should be scoped and always return the same value")
        XCTAssertFalse(user1root1.userProvider.get() === user1root2.userProvider.get(), "Different instances of the same component should return different objects")
    }

    func testSubcomponentsWithMultibindings() {
        let app = try! ComponentFactory.of(AppComponent.self).build(())

        XCTAssertEqual(
            app.allLoggedOutStrings.get().sorted(),
            ["A", "B", "C"]
        )

        XCTAssertEqual(
            app.loggedInComponentFactory.build("user-1").allLoggedInStrings.get().sorted(),
            ["A", "B", "C", "D", "E", "F"],
            "Subcomponents should be additive to collection bindings"
        )
    }
    
    private class App {
        let loggedInComponentFactory: ComponentFactory<LoggedInComponent>

        let allLoggedOutStrings: Provider<[String]>

        fileprivate init(
            loggedInComponentFactory: Provider<ComponentFactory<LoggedInComponent>>,
            allLoggedOutStrings: Provider<[String]>) {
            self.loggedInComponentFactory = loggedInComponentFactory.get()
            self.allLoggedOutStrings = allLoggedOutStrings
        }

        func nameOfUser(_ userID: String) -> String? {
            return loggedInComponentFactory.build(userID).userProvider.get().name
        }
    }

    private struct AppComponent : RootComponent {
        fileprivate typealias Root = App

        static func configure(binder: Binder<Singleton>) {
            binder.include(module: UserServiceModule.self)

            binder.install(dependency: LoggedInComponent.self)

            binder
                .bind(String.self)
                .intoCollection()
                .to(value: "A")

            binder
                .bind(String.self)
                .intoCollection()
                .to(value: "B")

            binder
                .bind(String.self)
                .intoCollection()
                .to(value: "C")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    private struct UserScoped : Scope {
    }

    private struct LoggedInRoot {
        var userProvider: Provider<User>
        var allLoggedInStrings: Provider<[String]>
    }

    private struct LoggedInComponent : Component {
        typealias Root = LoggedInRoot
        typealias Seed = TaggedProvider<UserID>  // Our seed is the UserID

        static func configure(binder: Binder<UserScoped>) {
            binder.bind().sharedInScope().to(factory: User.init)

            binder
                .bind(String.self)
                .intoCollection()
                .to(value: "D")

            binder
                .bind(String.self)
                .intoCollection()
                .to(value: "E")

            binder
                .bind(String.self)
                .intoCollection()
                .to(value: "F")
        }

        static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
            return bind.to(factory: Root.init)
        }
    }

    /// This represents the UserID of a
    private struct UserID : Tag {
        typealias Element = String
    }

    private class User {

        let id: String

        let userService: UserService

        init(id: TaggedProvider<UserID>, userService: UserService) {
            self.id = id.get()
            self.userService = userService
        }

        var name: String? {
            return userService.getNameForUser(userID: id)
        }
    }

    private struct UserServiceModule : Module {
        static func configure(binder: Binder<Singleton>) {
            binder
                .bind(UserService.self)
                .sharedInScope()
                .to(factory: UserServiceImpl.init)
        }
    }
}

private protocol UserService {
    func getNameForUser(userID: String) -> String?
}

private struct UserServiceImpl : UserService {
    typealias Scope = Singleton

    func getNameForUser(userID: String) -> String? {
        switch userID {
        case "user-1": return "User One"
        case "user-2": return "User Two"
        default: return nil
        }
    }
}

