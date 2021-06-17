
public enum AxisSet: String, Codable, ExpressibleByArrayLiteral {

    // MARK: Cases

    case horizontal = "h"
    case vertical = "v"
    case both = "hv"
    case none = ""

    // MARK: Initialization

    public init(arrayLiteral value: AxisSet...) {
        if value.contains(.both) {
            self = .both
        } else if value.contains(.vertical) {
            self = value.contains(.horizontal) ? .both : .vertical
        } else {
            self = value.contains(.horizontal) ? .horizontal : .none
        }
    }

}

#if canImport(SwiftUI)

extension AxisSet {

    var swiftUIValue: Axis.Set {
        switch self {
        case .horizontal:
            return .horizontal
        case .vertical:
            return .vertical
        case .both:
            return [.horizontal, .vertical]
        case .none:
            return []
        }
    }
}

#endif
