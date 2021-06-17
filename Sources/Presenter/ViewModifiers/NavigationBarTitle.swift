
public enum NavigationBarTitleDisplayMode: String, Codable {
    case inline
    case automatic
    case large
}

internal struct NavigationBarTitle: AnyViewModifying {

    // MARK: Stored Properties

    let title: Value<String>
    let displayMode: NavigationBarTitleDisplayMode?

}

// MARK: - CustomStringConvertible

extension NavigationBarTitle: CustomStringConvertible {

    var description: String {
        "navigationBarTitle(\(title), displayMode: \(displayMode ?? .automatic))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension NavigationBarTitle: ViewModifier {

    #if os(tvOS) || os(watchOS) || os(macOS)

    func body(content: Content) -> some SwiftUI.View {
        content
    }

    #else

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            content.navigationBarTitle(.init(self.title.get(from: model)),
                                       displayMode: self.displayMode?.swiftUIValue ?? .automatic)
        }
    }

    #endif

}

#if canImport(UIKit)

extension NavigationBarTitleDisplayMode {

    fileprivate var swiftUIValue: NavigationBarItem.TitleDisplayMode {
        switch self {
        case .automatic:
            return .automatic
        case .inline:
            return .inline
        case .large:
            #if os(tvOS) || os(watchOS)
            return .automatic
            #else
            return .large
            #endif
        }
    }
}

#endif

#endif

// MARK: - View Extensions

extension View {

    public func navigationBarTitle(_ title: Value<String>,
                                   displayMode: NavigationBarTitleDisplayMode? = nil) -> some View {
        modified(using: NavigationBarTitle(title: title, displayMode: displayMode))
    }

}
