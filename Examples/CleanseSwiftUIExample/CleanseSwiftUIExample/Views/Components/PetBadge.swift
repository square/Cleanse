//
//  PetBadge.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI


struct PetBadge: View {
    var type: Pet.PetType
    var body: some View {
        HStack {
            Image(petTypeIcon[type]!).renderingMode(.template).resizable().frame(width: 16, height: 16).foregroundColor(Color("on-primary"))
            Text(type.rawValue)
                .font(.caption)
                .fontWeight(.bold).foregroundColor(Color("on-primary"))
            }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).background(Color("primary")).clipShape(Capsule())
    }
}

struct PetBadge_Previews: PreviewProvider {
    static var previews: some View {
        PetBadge(type: Pet.PetType.dog)
    }
}
