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
    @State var navBarHidden: Bool = true
    var body: some View {
        NavigationView {
            List {
                HomeHeader().padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                ForEach(userData.pets) { pet in
                    PetRow(pet: pet)
                }
            }.environment(\.defaultMinListRowHeight, 132).listSeparatorStyleNone()
            .navigationBarTitle("")
            .navigationBarHidden(self.navBarHidden)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.navBarHidden = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.navBarHidden = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(UserData())
    }
}
