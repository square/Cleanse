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


var counter = 0

/// Useful for singletons
func nextCount() -> Int {
    counter += 1
    return counter
}



class SubcomponentTests: XCTestCase {

    func testSubcomponents() {
        let app = try! AppComponent().build()

        let user1root1 = app.loggedInComponentFactory.make("user-1")
        let user1root2 = app.loggedInComponentFactory.make("user-1")
        let user2root1 = app.loggedInComponentFactory.make("user-2")

        XCTAssertEqual(user1root1.userProvider.get().name, "User One")
    }

    class App : Scoped {
        typealias Scope = Singleton

        let loggedInComponentFactory: SubcomponentFactory<LoggedInComponent>

        public init(loggedInComponentFactory: SubcomponentFactory<LoggedInComponent>) {
            self.loggedInComponentFactory = loggedInComponentFactory
        }

        func nameOfUser(userID: String) -> String? {
            return loggedInComponentFactory.make(userID).userProvider.get().name
        }
    }

    struct AppComponent : RootComponent {
        public typealias Root = App

        func configure<B : Binder>(binder binder: B) {
            binder
                .bind(App.self)
                .to(factory: App.init)

            binder.install(module: UserServiceModule())

            binder.install(dependency: LoggedInComponent())
        }
    }

    struct UserScoped : Scope {
    }

    struct LoggedInRoot {
        var userProvider: Provider<User>
    }

    struct LoggedInComponent : Subcomponent {
        typealias Root = LoggedInRoot
        typealias Seed = TaggedProvider<UserID>  // Our seed is the UserID
        typealias Scope = UserScoped

        func configure<B : Binder>(binder binder: B) {
            binder.bind().to(factory: User.init)

            binder.bind().to(factory: LoggedInRoot.init)
        }
    }

    /// This represents the UserID of a
    struct UserID : Tag {
        typealias Element = String
    }

    class User : Scoped {
        public typealias Scope = UserScoped

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

    struct UserServiceModule : Module {
        func configure<B : Binder>(binder binder: B) {
            binder
                .bind(UserService.self)
                .to(factory: UserServiceImpl.init)
        }
    }
}
protocol UserService {
    func getNameForUser(userID userID: String) -> String?
}

struct UserServiceImpl : UserService, Scoped {
    typealias Scope = Singleton

    func getNameForUser(userID userID: String) -> String? {
        switch userID {
        case "user-1": return "User One"
        case "user-1": return "User Two"
        default: return nil
        }
    }
}

