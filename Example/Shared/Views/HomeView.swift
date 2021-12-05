//
//  HomeView.swift
//  Example
//
//  Created by Paul Kraft on 20.07.21.
//

import Presenter

struct HomeView: UserView {
    var body: View {
        VStack(spacing: 8) {
            Text("You are logged in!")
            Button(Text("Logout"), action: LogoutAction())
        }
        .onAppear(perform: LoadAction())
    }
}
