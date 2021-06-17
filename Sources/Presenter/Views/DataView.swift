
public struct DataView: SwiftUIView {

    // MARK: Stored Properties

    let data: Data

    // MARK: Initialization

    public init(_ data: Data) {
        self.data = data
    }

}

// MARK: - CustomStringConvertible

extension DataView: CustomStringConvertible {

    public var description: String {
        "DataView(\(String(data: data, encoding: .utf8) ?? "nil"))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

private struct _DataView: SwiftUI.View {

    let data: Data

    @SwiftUI.State private var view: AnyView?
    @SwiftUI.State private var didTryDecoding = false

    var body: some SwiftUI.View {
        if didTryDecoding {
            view
        } else {
            decode()
        }
    }

    private func decode() -> some SwiftUI.View {
        didTryDecoding = true
        view = try? Presenter.decode(from: data).eraseToAnyView()
        return view
    }

}

extension DataView {

    public var view: some SwiftUI.View {
        _DataView(data: data)
    }

}

#endif
