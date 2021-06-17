
import Presenter

typealias PresenterModel = Model

struct ContentView: View {
    @State("text", default: "") var text
    
    
    var body: some View {
        TextField("hallo", text: $text)
    }
}
