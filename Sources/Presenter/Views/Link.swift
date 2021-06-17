
public struct Link: SwiftUIView {

    // MARK: Stored Properties

    private let label: CoderView
    private let destination: String

    // MARK: Initialization

    public init<Label: View>(label: Label, destination: String) {
        self.label = CoderView(label)
        self.destination = destination
    }

}

// MARK: - CustomStringConvertible

extension Link: CustomStringConvertible {

    public var description: String {
        "Link(\(label), destination: \(destination))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Link {

    #if !os(macOS) && !targetEnvironment(macCatalyst)

    @SwiftUI.ViewBuilder
    public var view: some SwiftUI.View {
        if #available(iOS 14.0, tvOS 14.0, watchOS 7.0, *), let url = URL(string: destination) {
            SwiftUI.Link(destination: url, label: label.eraseToAnyView)
        } else {
            label.eraseToAnyView()
        }
    }

    #else

    public var view: some SwiftUI.View {
        label.eraseToAnyView()
    }

    #endif

}

#endif
