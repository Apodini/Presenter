//
//  Logout.swift
//  Example
//
//  Created by Paul Kraft on 20.07.21.
//
import Presenter

struct LogoutAction: Action {
    func perform(on model: Model) {
        model[.username] = nil
        model[.password] = nil
        model[.authenticationToken] = nil
        model[.isAuthenticated] = false
    }
}
