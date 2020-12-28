//
//  ContentView.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/7/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var userData: UserData
    
    let currentUser: User
    @State private var navBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    AccountSnippet(user: currentUser).padding(.top, 32)
                    PetHeader()
                    ForEach(userData.pets) { pet in
                        NavigationLink(destination: PetDetailScreen(pet: pet).navigationBarTitle(Text("")).navigationBarBackButtonHidden(false)) {
                            PetRow(pet: pet)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                        .background(Color.white)
                    }
                }.padding(.horizontal)
            }
            .navigationBarTitle("")
            .navigationBarHidden(self.navBarHidden)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.navBarHidden = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.navBarHidden = false
            }
            if UIDevice.current.userInterfaceIdiom == .pad {
                PetDetailScreen(pet: userData.pets[0])
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(currentUser: User(firstName: "John", lastName: "Doe", photo: "me", email: "abdc@fg.com")).environmentObject(UserData())
    }
}
