
public enum RoundedCornerStyle: String, Codable {
    case circular
    case continuous
}

#if canImport(SwiftUI)

extension RoundedCornerStyle {

    var swiftUIValue: SwiftUI.RoundedCornerStyle {
        switch self {
        case .circular:
            return .circular
        case .continuous:
            return .continuous
        }
    }

}

#endif
