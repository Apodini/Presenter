//
//  Model+Key.swift
//  Example
//
//  Created by Paul Kraft on 20.07.21.
//

import Presenter

extension Model.Key {

    static var username: Model.Key<String> {
        .init(rawValue: "login-username")
    }

    static var password: Model.Key<String> {
        .init(rawValue: "login-password")
    }

    static var authenticationToken: Model.Key<String> {
        .init(rawValue: "login-token")
    }

    static var isAuthenticated: Model.Key<Bool> {
        .init(rawValue: "login-active")
    }

    static var showLoginError: Model.Key<Bool> {
        .init(rawValue: "login-show-error")
    }

    static var loginErrorMessage: Model.Key<String> {
        .init(rawValue: "login-error-message")
    }

    static var isLoadingAllRecipes: Model.Key<Bool> {
        .init(rawValue: "recipe-all-loading")
    }

    static var allRecipeIdentifiers: Model.Key<[String]> {
        .init(rawValue: "recipe-all-ids")
    }

}

extension State {

    init(_ key: Model.Key<Content>, default defaultValue: Content) {
        self.init(key.rawValue, default: defaultValue)
    }

}

extension Model {

    struct Key<Value> {
        let rawValue: String
    }

    subscript<Value>(key: Key<Value>) -> Value? {
        get { get(key.rawValue) as? Value }
        set { set(key.rawValue, to: newValue) }
    }

}
