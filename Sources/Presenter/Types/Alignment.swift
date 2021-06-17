
public enum HorizontalAlignment: String, Codable {
    case center, leading, trailing
}

public enum VerticalAlignment: String, Codable {
    case center, top, bottom
}

public enum Alignment: String, Codable {
    case center, top, bottom, leading, trailing
    case topLeading, topTrailing
    case bottomLeading, bottomTrailing
}

#if canImport(SwiftUI)

extension HorizontalAlignment {

    var swiftUIValue: SwiftUI.HorizontalAlignment {
        switch self {
        case .center:
            return .center
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }

}

extension VerticalAlignment {

    var swiftUIValue: SwiftUI.VerticalAlignment {
        switch self {
        case .center:
            return .center
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }

}

extension Alignment {

    var swiftUIValue: SwiftUI.Alignment {
        switch self {
        case .center:
            return .center
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .topLeading:
            return .topLeading
        case .topTrailing:
            return .topTrailing
        case .bottomLeading:
            return .bottomLeading
        case .bottomTrailing:
            return .bottomTrailing
        }
    }

}

#endif
