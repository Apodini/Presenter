public struct Animation: Codable {
    // MARK: Stored Properties

    private var kind: Kind
    private var delay: Double?
    private var speed: Double?
    private var repeatCount: Int?
    private var autoreverses: Bool? // swiftlint:disable:this discouraged_optional_boolean

    // MARK: Static Functions

    public static func spring(response: Double? = nil, damping: Double? = nil, blendDuration: Double? = nil) -> Animation {
        Animation(kind:
            .spring(response: response, damping: damping, blendDuration: blendDuration)
        )
    }

    public static func interpolatingSpring(mass: Double? = nil,
                                           stiffness: Double,
                                           damping: Double,
                                           initialVelocity: Double? = nil) -> Animation {
        Animation(kind:
            .interpolatingSpring(mass: mass,
                                 stiffness: stiffness,
                                 damping: damping,
                                 initialVelocity: initialVelocity)
        )
    }

    public static var `default`: Animation {
        Animation(kind: .default)
    }

    public static func easeIn(duration: Double?) -> Animation {
        Animation(kind: .easeIn(duration: duration))
    }

    public static var easeIn: Animation {
        Animation(kind: .easeIn(duration: nil))
    }

    public static func easeOut(duration: Double?) -> Animation {
        Animation(kind: .easeOut(duration: duration))
    }

    public static var easeOut: Animation {
        Animation(kind: .easeOut(duration: nil))
    }

    public static func easeInOut(duration: Double?) -> Animation {
        Animation(kind: .easeInOut(duration: duration))
    }

    public static var easeInOut: Animation {
        Animation(kind: .easeInOut(duration: nil))
    }

    public static func linear(duration: Double?) -> Animation {
        Animation(kind: .linear(duration: duration))
    }

    public static var linear: Animation {
        Animation(kind: .linear(duration: nil))
    }

    public static func timingCurve(c0x: Double,
                                   c0y: Double,
                                   c1x: Double,
                                   c1y: Double,
                                   duration: Double? = nil) -> Animation {
        Animation(kind: .timingCurve(c0x: c0x, c0y: c0y, c1x: c1x, c1y: c1y, duration: duration))
    }

    internal static var none: Animation {
        Animation(kind: .none)
    }

    // MARK: Methods

    public func delay(_ interval: Double) -> Animation {
        Animation(kind: kind,
                  delay: (delay ?? 0) + interval,
                  speed: speed,
                  repeatCount: repeatCount,
                  autoreverses: autoreverses)
    }

    public func repeatCount(_ count: Int, autoreverses: Bool = true) -> Animation {
        Animation(kind: kind, delay: delay, speed: speed, repeatCount: count, autoreverses: autoreverses)
    }

    public func repeatForever(autoreverses: Bool = true) -> Animation {
        Animation(kind: kind, delay: delay, speed: speed, repeatCount: -1, autoreverses: autoreverses)
    }

    public func speed(_ speed: Double) -> Animation {
        Animation(kind: kind, delay: delay, speed: speed, repeatCount: repeatCount, autoreverses: autoreverses)
    }
}

extension Animation: CustomStringConvertible {
    public var description: String {
        if case .none = kind {
            return "nil"
        }

        let repeating: String = repeatCount.flatMap { repeatCount -> String? in
            if repeatCount < 0 {
                return ".repeatForever(autoreverses: \(autoreverses ?? true))"
            } else if repeatCount == 0 {
                return nil
            } else {
                return ".repeatCount(\(repeatCount), autoreverses: \(autoreverses ?? true))"
            }
        } ?? ""

        let operators = (delay.map { ".delay(\($0))" } ?? "")
            + (speed.map { ".speed(\($0))" } ?? "")
            + repeating

        if operators.isEmpty {
            return ".\(kind)"
        } else {
            return "Animation.\(kind)" + operators
        }
    }
}

extension Animation {
    enum Kind: Codable {
        // MARK: Cases

        case spring(response: Double?, damping: Double?, blendDuration: Double?)
        case interpolatingSpring(mass: Double?, stiffness: Double, damping: Double, initialVelocity: Double?)
        case `default`
        case easeIn(duration: Double?)
        case easeOut(duration: Double?)
        case easeInOut(duration: Double?)
        case linear(duration: Double?)
        case none
        case timingCurve(c0x: Double, c0y: Double, c1x: Double, c1y: Double, duration: Double?)
        // swiftlint:disable:previous enum_case_associated_values_count

        // MARK: Nested Types

        private enum Name: String, Codable {
            case spring
            case interpolatingString
            case `default`
            case easeIn
            case easeOut
            case easeInOut
            case linear
            case timingCurve
            case none
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case response
            case damping
            case blendDuration
            case mass
            case stiffness
            case initialVelocity
            case duration
            case c0x, c0y, c1x, c1y
        }

        // MARK: Initialization

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let duration = try container.decodeIfPresent(Double.self, forKey: .duration)
            switch try container.decode(Name.self, forKey: .name) {
            case .spring:
                let response = try container.decodeIfPresent(Double.self, forKey: .response)
                let damping = try container.decodeIfPresent(Double.self, forKey: .damping)
                let blendDuration = try container.decodeIfPresent(Double.self, forKey: .blendDuration)
                self = .spring(response: response, damping: damping, blendDuration: blendDuration)
            case .interpolatingString:
                let mass = try container.decodeIfPresent(Double.self, forKey: .mass)
                let stiffness = try container.decode(Double.self, forKey: .stiffness)
                let damping = try container.decode(Double.self, forKey: .damping)
                let initialVelocity = try container.decodeIfPresent(Double.self, forKey: .initialVelocity)
                self = .interpolatingSpring(mass: mass,
                                            stiffness: stiffness,
                                            damping: damping,
                                            initialVelocity: initialVelocity)
            case .default:
                self = .default
            case .easeIn:
                self = .easeIn(duration: duration)
            case .easeOut:
                self = .easeOut(duration: duration)
            case .easeInOut:
                self = .easeInOut(duration: duration)
            case .linear:
                self = .linear(duration: duration)
            case .timingCurve:
                let c0x = try container.decode(Double.self, forKey: .c0x)
                let c0y = try container.decode(Double.self, forKey: .c0y)
                let c1x = try container.decode(Double.self, forKey: .c1x)
                let c1y = try container.decode(Double.self, forKey: .c1y)
                self = .timingCurve(c0x: c0x,
                                    c0y: c0y,
                                    c1x: c1x,
                                    c1y: c1y,
                                    duration: duration)
            case .none:
                self = .none
            }
        }

        // MARK: Methods

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .spring(response, damping, blendDuration):
                try container.encode(Name.spring, forKey: .name)
                try container.encodeIfPresent(response, forKey: .response)
                try container.encodeIfPresent(damping, forKey: .damping)
                try container.encodeIfPresent(blendDuration, forKey: .blendDuration)
            case let .interpolatingSpring(mass, stiffness, damping, initialVelocity):
                try container.encode(Name.interpolatingString, forKey: .name)
                try container.encodeIfPresent(mass, forKey: .mass)
                try container.encode(stiffness, forKey: .stiffness)
                try container.encode(damping, forKey: .damping)
                try container.encodeIfPresent(initialVelocity, forKey: .initialVelocity)
            case .default:
                try container.encode(Name.default, forKey: .name)
            case let .easeIn(duration):
                try container.encode(Name.easeIn, forKey: .name)
                try container.encodeIfPresent(duration, forKey: .duration)
            case let .easeOut(duration):
                try container.encode(Name.easeOut, forKey: .name)
                try container.encodeIfPresent(duration, forKey: .duration)
            case let .easeInOut(duration):
                try container.encode(Name.easeInOut, forKey: .name)
                try container.encodeIfPresent(duration, forKey: .duration)
            case let .linear(duration):
                try container.encode(Name.linear, forKey: .name)
                try container.encodeIfPresent(duration, forKey: .duration)
            case let .timingCurve(c0x, c0y, c1x, c1y, duration):
                try container.encode(Name.timingCurve, forKey: .name)
                try container.encode(c0x, forKey: .c0x)
                try container.encode(c0y, forKey: .c0y)
                try container.encode(c1x, forKey: .c1x)
                try container.encode(c1y, forKey: .c1y)
                try container.encodeIfPresent(duration, forKey: .duration)
            case .none:
                try container.encode(Name.none, forKey: .name)
            }
        }
    }
}

extension Animation.Kind: CustomStringConvertible {
    var description: String {
        switch self {
        case let .spring(response, damping, blendDuration):
            let values = [("response", response), ("damping", damping), ("blendDuration", blendDuration)]
                .filter { $0.1 != nil }
                .map { "\($0.0): \($0.1!)" }
                .joined(separator: ", ")
            return "spring(\(values))"
        case let .interpolatingSpring(mass, stiffness, damping, initialVelocity):
            let values = [("mass", mass), ("stiffness", stiffness), ("damping", damping), ("initialVelocity", initialVelocity)]
                .filter { $0.1 != nil }
                .map { "\($0.0): \($0.1!)" }
                .joined(separator: ", ")
            return "interpolatingSpring(\(values))"
        case .default:
            return "default"
        case let .easeIn(duration):
            return "easeIn" + (duration.map { "(duration: \($0))" } ?? "")
        case let .easeOut(duration):
            return "easeOut" + (duration.map { "(duration: \($0))" } ?? "")
        case let .easeInOut(duration):
            return "easeInOut" + (duration.map { "(duration: \($0))" } ?? "")
        case let .linear(duration):
            return "linear" + (duration.map { "(duration: \($0))" } ?? "")
        case let .timingCurve(c0x, c0y, c1x, c1y, duration):
            return "timingCurve(c0x: \(c0x), c0y: \(c0y), c1x: \(c1x), c1y: \(c1y)"
                + (duration.map { ", duration: \($0)" } ?? "")
                + ")"
        case .none:
            return "none"
        }
    }
}

#if canImport(SwiftUI)

extension Animation {
    internal var animation: SwiftUI.Animation? {
        guard var animation = kind.animation else {
            return nil
        }
        if let delay = delay {
            animation = animation.delay(delay)
        }
        if let speed = speed {
            animation = animation.speed(speed)
        }
        if let repeatCount = repeatCount {
            if repeatCount > 0 {
                animation = animation
                    .repeatCount(repeatCount, autoreverses: autoreverses ?? true)
            } else if repeatCount != 0 {
                animation = animation
                    .repeatForever(autoreverses: autoreverses ?? true)
            }
        }
        return animation
    }
}

extension  Animation.Kind {
    var animation: SwiftUI.Animation? {
        switch self {
        case .none:
            return nil
        case let .spring(response, damping, blendDuration):
            return .spring(response: response ?? 0.55,
                           dampingFraction: damping ?? 0.825,
                           blendDuration: blendDuration ?? 0)
        case let .interpolatingSpring(mass, stiffness, damping, initialVelocity):
            return .interpolatingSpring(mass: mass ?? 1,
                                        stiffness: stiffness,
                                        damping: damping,
                                        initialVelocity: initialVelocity ?? 0)
        case .default:
            return .default
        case let .easeIn(duration):
            return duration.map { .easeIn(duration: $0) } ?? .easeIn
        case .easeOut(duration: let duration):
            return duration.map { .easeOut(duration: $0) } ?? .easeOut
        case .easeInOut(duration: let duration):
            return duration.map { .easeInOut(duration: $0) } ?? .easeInOut
        case .linear(duration: let duration):
            return duration.map { .linear(duration: $0) } ?? .linear
        case let .timingCurve(c0x: c0x, c0y: c0y, c1x: c1x, c1y: c1y, duration: duration):
            return .timingCurve(c0x, c0y, c1x, c1y, duration: duration ?? 0.35)
        }
    }
}

#endif
