//
//  AboutScreen.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct AboutScreen: View {
    @State private var navBarHidden: Bool = false
    let user: User
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    Circle().frame(width: 90, height: 90).padding(.top, 90).foregroundColor(Color("primary"))
                    Image(user.photo).resizable().scaledToFill().clipShape(Circle()).frame(height: 316, alignment: .center).padding(EdgeInsets(top: -56, leading: 62, bottom: 62, trailing: -120))
                    Circle().frame(width: 198, height: 156).padding(EdgeInsets(top: 220, leading: 36, bottom: 0, trailing: 0)).foregroundColor(Color("primary"))
                }
                VStack(alignment: .leading) {
                    Text(user.fullName).font(.largeTitle).fontWeight(.bold)
                    Text(user.email).font(.body).fontWeight(.bold)
                }.padding()
                VStack(alignment: .leading) {
                    Text("Credits").font(.largeTitle).fontWeight(.bold)
                    Text("Unsplash\nfor the awesome pet photos").lineLimit(2).padding(.bottom).fixedSize()
                    Text("Freepik\nfor the illustrations @pikisuperstar").lineLimit(2).padding(.bottom).fixedSize()
                    Text("FontAwesome\nfor the pet icons").lineLimit(2).padding(.bottom).fixedSize()
                }.padding(.leading, 16)
                Image("illustration-dog").resizable().scaledToFill().frame(width: 216, height: 216).padding(.leading, 16)
                Spacer()
            }.navigationBarTitle(Text("User Detail")).navigationBarHidden( self.navBarHidden)
        }
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen(user: User(firstName: "John", lastName: "Doe", photo: "me", email: "abcd@ef.com"))
    }
}
