
import SwiftUI

@available(macOS 11.0, iOS 14.0, *)
struct ExampleApp: App {
    @StateObject var model = PresenterModel()

    init() {
        print(Self.self, #function)
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .eraseToAnyView()
                .environmentObject(model)
        }
    }

}


struct ContentView_Provider: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView().eraseToAnyView()
    }
}

