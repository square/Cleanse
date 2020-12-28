//
//  User.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Cleanse

struct User {
    let firstName: String
    let lastName: String
    let photo: String
    var fullName : String {
        get {
            firstName + " " + lastName
        }
    }
    let email: String
}

extension User {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(User.self).to {
                User(firstName: "John", lastName: "Doe", photo: "me", email: "abcd@ef.com")
            }
        }
    }
}
