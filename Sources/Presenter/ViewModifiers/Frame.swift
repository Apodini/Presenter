
internal struct Frame: AnyViewModifying {

    // MARK: Stored Properties

    let height: CGFloat?
    let width: CGFloat?
    let alignment: Alignment?

}

// MARK: - CustomStringConvertible

extension Frame: CustomStringConvertible {

    var description: String {
        let values: [(String, Any?)] = [("height", height), ("width", width), ("alignment", alignment)]
        let nonOptionalValues = values.filter { $0.1 != nil }
        return "frame(\(nonOptionalValues.map { "\($0.0): \($0.1!)" }.joined(separator: ", ")))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Frame: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.frame(width: width, height: height,
                      alignment: alignment?.swiftUIValue ?? .center)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment? = nil) -> some View {
        modified(using: Frame(height: height, width: width, alignment: alignment))
    }

}
