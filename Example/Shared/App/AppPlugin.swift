//
//  AppPlugin.swift
//  Example
//
//  Created by Paul Kraft on 20.07.21.
//

import Presenter
import MetricPresenter
import TracePresenter

struct AppPlugin: Plugin {
    var plugins: [Plugin] {
        [
            MetricPresenter(),
            TracePresenter()
        ]
    }

    var actions: [Action.Type] {
        [
            LoadAction.self,
            LoginAction.self,
            LogoutAction.self
        ]
    }
}
