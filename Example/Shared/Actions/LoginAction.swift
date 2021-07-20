//
//  LoginAction.swift
//  Example
//
//  Created by Paul Kraft on 20.07.21.
//

import Presenter

struct LoginAction: Action {

    func perform(on model: Model) {
        guard let username = model[.username],
              let password = model[.password] else {
            model[.loginErrorMessage] = "Could not find username or password."
            model[.showLoginError] = true
            return
        }

        guard username.count > 0 && password.count > 0 else {
            model[.loginErrorMessage] = "Please enter username and password."
            model[.showLoginError] = true
            return
        }

        let prefix = Data(username.utf8).base64EncodedString()
        let suffix = Data(password.utf8).base64EncodedString()
        model[.authenticationToken] = prefix + ":" + suffix
        model[.isAuthenticated] = true
    }

}
