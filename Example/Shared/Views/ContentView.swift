//
//  ContentView.swift
//  Shared
//
//  Created by Paul Kraft on 20.07.21.
//

import Presenter

typealias PresenterModel = Model
typealias PresenterView = View

struct ContentView: UserView {
    @State(.isAuthenticated, default: false) var isAuthenticated

    var body: View {
        If(isAuthenticated,
           then: HomeView(),
           else: LoginView())
    }
}
