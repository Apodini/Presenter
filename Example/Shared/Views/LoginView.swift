//
//  LoginView.swift
//  Example
//
//  Created by Paul Kraft on 20.07.21.
//

import Presenter

struct LoginView: UserView {

    @State(.username, default: "") var username
    @State(.password, default: "") var password
    @State(.showLoginError, default: false) var showLoginError
    @State(.loginErrorMessage, default: "Unknown Error") var loginErrorMessage

    var body: View {
        VStack {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button(Text("Login"), action: LoginAction())
        }
        .padding(16)
        .background(Color(red: 1, green: 1, blue: 1))
        .cornerRadius(8)
        .shadow(radius: 8)
        .padding(16)
        .sheet(isPresented: $showLoginError, content: Text(loginErrorMessage))
    }

}
