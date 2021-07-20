
internal struct DynamicFrame: CodableViewModifier {

    // MARK: Stored Properties

    let minWidth: CGFloat?
    let idealWidth: CGFloat?
    let maxWidth: CGFloat?

    let minHeight: CGFloat?
    let idealHeight: CGFloat?
    let maxHeight: CGFloat?

    let alignment: Alignment?

}

// MARK: - CustomStringConvertible

extension DynamicFrame: CustomStringConvertible {

    var description: String {
        let values: [(String, Any?)] = [
            ("minWidth", minWidth), ("idealWidth", idealWidth), ("maxWidth", maxWidth),
            ("minHeight", minHeight), ("idealHeight", idealHeight), ("maxHeight", maxHeight),
            ("alignment", alignment)
        ]
        let nonOptionalValues = values.filter { $0.1 != nil }
        return "frame(\(nonOptionalValues.map { "\($0.0): \($0.1!)" }.joined(separator: ", ")))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension DynamicFrame: SwiftUI.ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.frame(minWidth: minWidth,
                      idealWidth: idealWidth,
                      maxWidth: maxWidth,
                      minHeight: minHeight,
                      idealHeight: idealHeight,
                      maxHeight: maxHeight,
                      alignment: alignment?.swiftUIValue ?? .center)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func frame(minWidth: CGFloat? = nil,
                      idealWidth: CGFloat? = nil,
                      maxWidth: CGFloat? = nil,
                      minHeight: CGFloat? = nil,
                      idealHeight: CGFloat? = nil,
                      maxHeight: CGFloat? = nil,
                      alignment: Alignment = .center) -> View {
        modifier(
            DynamicFrame(
                minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth,
                minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight,
                alignment: alignment
            )
        )
    }

}
