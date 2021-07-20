import Presenter

typealias PresenterModel = Model

struct ContentView: UserView {
    @State("text", default: "") var text
    
    var body: View {
        TextField("hallo", text: $text)
    }
}
