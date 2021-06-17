
internal struct Clipped: AnyViewModifying {

    // MARK: Stored Properties

    let antialiased: Bool?

}

// MARK: - CustomStringConvertible

extension Clipped: CustomStringConvertible {

    var description: String {
        "clipped(antialiased: \(antialiased ?? false))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Clipped: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.clipped(antialiased: antialiased ?? false)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func clipped(antialiased: Bool? = nil) -> some View {
        modified(using: Clipped(antialiased: antialiased))
    }

}
