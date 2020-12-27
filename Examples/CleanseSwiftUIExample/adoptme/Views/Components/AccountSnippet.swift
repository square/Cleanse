//
//  HomeHeader.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct AccountSnippet: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: AboutScreen(user: user)){
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(user.lastName).font(.largeTitle).fontWeight(.bold).foregroundColor(.black)
                        Text("Some text that supposed\nto describes something")
                            .font(.caption)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.gray)
                        HStack {
                            Text("Account").font(.body).foregroundColor(Color("on-primary"))
                            Image(systemName: "chevron.right.2").foregroundColor(Color("on-primary"))
                        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).background(Color("primary")).clipShape(Capsule())
                    }
                    Spacer()
                    Image(user.photo).resizable().frame(width: 120, height: 120).clipShape(Circle())
                }
            }
            
            Text("Complete Your Profile").font(.headline)
            ProgressBar().frame(width: 216)
            Spacer()
        }
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        AccountSnippet(user: User(firstName: "Abdul", lastName: "Chathil",photo: "me",  email: "chathil98@gmail.com"))
    }
}
