//
//  Pet.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/7/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

let petTypeIcon = [Pet.PetType.cat: "cat-solid", Pet.PetType.dog: "dog-solid", Pet.PetType.chameleon: "otter-solid"]

struct Pet: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    var type: PetType
    var desc: String
    var isLiked: Bool
    var isMale: Bool
    var size: PetSize
    var location: String
    
    enum PetType: String, CaseIterable, Codable, Hashable {
        case cat = "Cat"
        case dog = "Dog"
        case chameleon = "Chameleon"
    }
    
    enum PetSize: String, CaseIterable, Codable, Hashable {
        case s = "S"
        case m = "M"
        case l = "L"
    }
    
}

extension Pet {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
