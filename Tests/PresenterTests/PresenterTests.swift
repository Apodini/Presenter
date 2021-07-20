#if !os(watchOS) && canImport(XCTest) && canImport(SwiftUI)

import XCTest
import Presenter

typealias _Model = Model

struct TestAction: Action {
    func perform(on model: Model) {
        model.set("login-title", to: "Success")
    }
}

extension Color {
    static var gray: Color {
        Color(red: 0.5, green: 0.5, blue: 0.5)
    }
}

struct MyCustomView: UserView {
    @State("text", default: "")
    var text

    @Binding
    var text2: Value<String>

    var body: View {
        VStack {
            TextField(text2, text: $text)
            MyCustomView2()
        }
    }
}

struct MyCustomView2: UserView {
    var body: View {
        Text("gallo")
    }
}

final class PresenterTests: XCTestCase {
    func testCustom() throws {
        let view = MyCustomView(text2: .at("test", default: ""))
        let data = try Presenter.encode(view)
        print(String(data: data, encoding: .utf8) ?? "nil")
    }

    func testExample() {
        let optional: Text? = nil

        let serverView = HStack(spacing: 8) {
            Text("Hallo")
                .padding(8)
                .frame(minWidth: 10, idealWidth: 30, maxWidth: 50,
                       minHeight: 100, idealHeight: 110, maxHeight: 120,
                       alignment: .center)

            Text("Check")
                .frame(width: 100)

            optional

            Text("What")
                .padding(8)
                .background(Color.gray)
        }

        check(serverView)
    }

    func testLogin() {
        Presenter.use(action: TestAction.self)

        let view = HStack {
            VStack {
                Spacer(minLength: 8)
                TextField("Username", text: .at("username", default: ""))
                Spacer(minLength: 8)
                SecureField("Password", text: .at("password", default: ""))
                Spacer(minLength: 8)
                Button(Text(.at("login-title", default: "Login")),
                       action: TestAction())
                .padding(8)
                .animation(
                    Animation
                    .timingCurve(c0x: 1, c0y: 0, c1x: 1, c1y: 0, duration: 5)
                    .delay(2)
                    .repeatForever(autoreverses: false)
                )
                .animation(.default)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .background(Color.gray)
                .animation(nil)

                Spacer(minLength: nil)
            }
            .padding(leading: 16, trailing: 16)
        }

        check(view)
    }

    func testJSAction() {
        let model = Model()
        model.set("two", to: Int(2))
        model.set("three", to: Int(3))
        let action = JavaScriptAction(
            script: """
            var five = two + three
            return five
            """,
            inputs: ["two", "three"],
            resultKey: "five",
            errorKey: "error"
        )
        action.perform(on: model)
        XCTAssert((model.get("error") as AnyObject) is NSNull,
                  "\(String(describing: model.get("error")))")
        XCTAssertEqual(model.get("five") as? Int, 5)
    }

    private func check<V: View>(_ serverView: V) {
        do {
            let data = try Presenter.encode(serverView)
            print(String(data: data, encoding: .utf8) ?? "nil")
            let clientView = try Presenter.decode(from: data)
            print(clientView)
            XCTAssertEqual("\(clientView)", "\(serverView)")
        } catch {
            XCTFail("\(error)")
        }
    }
}

#endif
