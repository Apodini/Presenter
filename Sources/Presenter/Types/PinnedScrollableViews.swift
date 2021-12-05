public struct PinnedScrollableViews: Codable, OptionSet {
    // MARK: Stored Properties

    public var rawValue: UInt32

    // MARK: Initialization

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    // MARK: Static Properties

    public static let sectionHeaders: PinnedScrollableViews = .init(rawValue: 1 << 1)
    public static let sectionFooters: PinnedScrollableViews = .init(rawValue: 1 << 0)
}

#if canImport(SwiftUI)

extension PinnedScrollableViews {
    #if !os(macOS) && !targetEnvironment(macCatalyst)

    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    var swiftUIValue: SwiftUI.PinnedScrollableViews {
        var value = SwiftUI.PinnedScrollableViews()
        if contains(.sectionHeaders) {
            value.insert(.sectionHeaders)
        }
        if contains(.sectionFooters) {
            value.insert(.sectionFooters)
        }
        return value
    }

    #endif
}

#endif
