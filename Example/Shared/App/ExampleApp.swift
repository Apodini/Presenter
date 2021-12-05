//
//  ExampleApp.swift
//  Shared
//
//  Created by Paul Kraft on 20.07.21.
//

import Presenter
import SwiftUI

@main
struct ExampleApp: App {
    // MARK: Stored Properties

    @SwiftUI.StateObject private var model = Model()
    @SwiftUI.State private var view: AnyView?

    // MARK: Initialization

    init() {
        Presenter.use(plugin: AppPlugin())
    }

    // MARK: Views

    var body: some Scene {
        WindowGroup {
            load(ContentView())
                .environmentObject(model)
        }
    }

    // MARK: Helpers

    private func load<V: PresenterView>(_ presenterView: V) -> AnyView? {
        if let view = view {
            return view
        }
        DispatchQueue.global(qos: .userInitiated).async {
            let view: AnyView
            do {
                let data = try Presenter.encode(presenterView)
                view = try Presenter.decode(from: data)
                    .eraseToAnyView()
            } catch {
                view = AnyView(SwiftUI.Text(error.localizedDescription))
            }
            DispatchQueue.main.async {
                self.view = view
            }
        }
        return nil
    }
}
