# Presenter

The `Presenter` framework to encode, decode and use distributed user interfaces. While `Presenter` can be used on a server to encode user interfaces in a similar style to SwiftUI, it can be used on the client-side (iOS, watchOS, tvOS and macOS) to decode these user interfaces and display to the user using the SwiftUI framework.

## Features

- Create user interfaces on the server using a declarative DSL similar to SwiftUI
- Encode the user interface using the Codable API (e.g. to JSON)
- Decode the user interface using the Codable API (e.g. from JSON)
- Display the user interface using SwiftUI Components

- Use local memory to store temporary state
- Interact with system functionality using local actions
- Create custom views, view modifiers and actions
- Add plugins with custom views, view modifiers and actions

## Installation

Presenter uses the Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/Apodini/Presenter.git", from: "0.1.0")
]
```

After specifying the package as a dependency, you can use it in your targets.

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "Presenter", package: "Presenter")
        ]
    )
]
```

## Usage

### Server

You can specify `Presenter` views similar to SwiftUI.

```swift
struct LoginView: UserView {

    @State("login-username", default: "") var username
    @State("login-password", default: "") var password

    var body: View {
        VStack {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button(Text("Login"), action: LoginAction())
        }
        .padding(16)
        .background(Color(red: 1, green: 1, blue: 1))
        .shadow(radius: 8)
        .padding(16)
    }

}
```

This example above already showcases some of the more complicated features of SwiftUI, including state management and local actions.

### Client

On the client side, `Presenter` uses `ServedView` to provide a SwiftUI interface from a url or a custom publisher.

```swift
import Presenter
import SwiftUI

struct ContentView: SwiftUI.View {

    @StateObject var model = Model()

    var body: some SwiftUI.View {
        ServedView(url: URL(string: "..."), model: model) { state in
            switch state {
            case .empty:
                Text("Empty")
            case .loading:
                Text("Loading")
            case let .failure(error):
                Text("Error: " + error.localizedDescription)
            }
        }
    }

}
```

When using plugins, custom views, custom view modifiers or actions, please make sure to register them during app start using  `Presenter.use(plugin:)`, `Presenter.use(view:)`, `Presenter.use(modifier:)` or `Presenter.use(action:)` respectively. Tip: You can also create an app-specific plugin to register multiple views, view modifiers and actions at once.

## Example

We provide a small example project to showcase Presenter.

Clone the repo, navigate in the root folder and start the example server application using `swift run Example`.
To check out how to use Presenter on the client side, see the [example client application](Example).

## Contributing

Contributions to this projects are welcome. Please make sure to read the [contribution guidelines](https://github.com/Apodini/.github/blob/release/CONTRIBUTING.md) first.

## License

This project is licensed under the MIT License. See [License](https://github.com/Apodini/Presenter/blob/release/LICENSE) for more information.
