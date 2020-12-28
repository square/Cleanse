//
//  PetRow.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/7/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI



struct PetRow: View {
    @EnvironmentObject var userData: UserData
    var pet: Pet
    var petIndex: Int {
        userData.pets.firstIndex(where: { $0.id == pet.id })!
    }
    var body: some View {
        HStack {
            pet.image.resizable().scaledToFill().frame(width: 112, height: 112, alignment: .center).clipped()
            VStack(alignment: .leading) {
                Text(pet.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(pet.location).foregroundColor(.black)
                HStack {
                    LikeButton(isLiked: self.userData.pets[self.petIndex].isLiked).padding().onTapGesture {
                        self.userData.pets[self.petIndex].isLiked.toggle()
                    }
                    PetBadge(type: pet.type)
                }
            }
            Spacer()
        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    static let gradientStart = Color(red: 0.0 / 255, green: 150.0 / 255, blue: 136.0 / 255)
    static let gradientEnd = Color(red: 224.0 / 255, green: 242.0 / 255, blue: 241.0 / 255)
}

struct PetRow_Previews: PreviewProvider {
    static var previews: some View {
        PetRow(pet: petData[0]).environmentObject(UserData())
    }
}
