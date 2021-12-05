public struct DataView: CodableView {
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
        DispatchQueue.main.async {
            self.didTryDecoding = true
            do {
                let decodedView = try Presenter.decode(from: data)
                self.view = decodedView.eraseToAnyView()
            } catch {
                self.view = AnyView(SwiftUI.Text(error.localizedDescription))
            }
        }
        return view
    }
}

extension DataView: SwiftUI.View {
    public var body: some SwiftUI.View {
        _DataView(data: data)
    }
}

#endif
