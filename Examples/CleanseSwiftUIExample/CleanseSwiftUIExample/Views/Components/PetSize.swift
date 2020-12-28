//
//  PetSize.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct PetSize: View {
    let pet: Pet
    var body: some View {
        HStack(alignment: .bottom) {
            Image(petTypeIcon[pet.type]!).resizable().renderingMode(.template).frame(width: 24, height: 24).foregroundColor(pet.size == Pet.PetSize.s ? Color("on-primary") : Color("primary"))
            Image(petTypeIcon[pet.type]!).resizable().renderingMode(.template).frame(width: 48, height: 48).foregroundColor(pet.size == Pet.PetSize.m ? Color("on-primary") : Color("primary"))
            Image(petTypeIcon[pet.type]!).resizable().renderingMode(.template).frame(width: 72, height: 72).foregroundColor(pet.size == Pet.PetSize.l ? Color("on-primary") : Color("primary"))
        }
    }
}

struct PetSize_Previews: PreviewProvider {
    static var previews: some View {
        PetSize(pet: petData[0])
    }
}
