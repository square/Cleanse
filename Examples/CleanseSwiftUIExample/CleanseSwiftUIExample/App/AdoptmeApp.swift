//
//  AdoptmeApp.swift
//  adoptme
//
//  Created by Abdul Chathil on 12/25/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse

@main
class AdoptmeApp: App {
    var userData: UserData!
    var user: User!
    
    required init() {
        let propertyInjector = try? ComponentFactory.of(AppComponent.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(userData != nil)
        precondition(user != nil)
    }
    var body: some Scene {
        WindowGroup {
            HomeScreen(currentUser: user).environmentObject(userData)
        }
    }
}

extension AdoptmeApp {
    func injectProperties(_ userData: UserData, _ user: User) {
        self.userData = userData
        self.user = user
    }
}
