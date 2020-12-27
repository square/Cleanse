//
//  PetDetailScreen.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct PetDetailScreen: View {
    @EnvironmentObject private var userData: UserData
    @State private var navBarHidden: Bool = true
    let pet: Pet
    var petIndex: Int {
        userData.pets.firstIndex(where: { $0.id == pet.id })!
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                pet.image.resizable().scaledToFill().frame(height: 316).clipped()
                HStack(alignment: .bottom){
                    VStack(alignment: .leading) {
                        Text(pet.name).font(.largeTitle).fontWeight(.bold)
                        Text(pet.location).font(.caption).fontWeight(.medium)
                    }
                    Spacer()
                    PetSize(pet: pet)
                }.padding()
                HStack() {
                    PetBadge(type: pet.type).frame(minWidth: 90, alignment: .leading)
                    Text(pet.isMale ? "Male" : "Female").font(.caption).foregroundColor(Color("on-primary")).bold().padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).background(Color("primary")).clipShape(Capsule())
                    Spacer()
                    LikeButton(isLiked: self.userData.pets[self.petIndex].isLiked).padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)).onTapGesture {
                        self.userData.pets[self.petIndex].isLiked.toggle()
                    }
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                Text(pet.desc).font(.body).padding()
            }
        }.edgesIgnoringSafeArea(.top).navigationBarHidden(false)
    }
}

struct PetDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailScreen(pet: petData[7]).environmentObject(UserData())
    }
}
