public struct If: CodableWrapperView { // swiftlint:disable:this type_name
    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case condition = "if"
        case trueView = "then"
        case falseView = "else"
    }

    // MARK: Stored Properties

    private let condition: Value<Bool>
    private let trueView: CoderView
    private let falseView: CoderView

    // MARK: Initialization

    public init(
        _ condition: Value<Bool>,
        then trueView: View,
        else falseView: View
    ) {
        self.condition = condition
        self.trueView = CoderView(trueView)
        self.falseView = CoderView(falseView)
    }

    public init(
        _ condition: Value<Bool>,
        then trueView: View
    ) {
        self.condition = condition
        self.trueView = CoderView(trueView)
        self.falseView = CoderView(Nil())
    }

    public init(
        _ condition: Value<Bool>,
        else falseView: View
    ) {
        self.condition = condition
        self.trueView = CoderView(Nil())
        self.falseView = CoderView(falseView)
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        if condition.key == nil {
            if condition.default {
                try trueView.encode(to: encoder)
            } else {
                try falseView.encode(to: encoder)
            }
        } else {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(condition, forKey: .condition)
            try container.encode(trueView, forKey: .trueView)
            try container.encode(falseView, forKey: .falseView)
        }
    }
}

// MARK: - CustomStringConvertible

extension If: CustomStringConvertible {
    public var description: String {
        "If(\(condition), then: \(trueView), else: \(falseView))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension If {
    public var body: View {
        trueView.modifier(Modifier1(falseView: falseView, condition: condition))
    }
}

private struct Modifier1: ViewModifier {
    let falseView: CoderView
    let condition: Value<Bool>

    func body<Content: SwiftUI.View>(for content: Content) -> View {
        falseView.modifier(Modifier2(trueView: content, condition: condition))
    }
}

private struct Modifier2<TrueView: SwiftUI.View>: ViewModifier, SwiftUI.ViewModifier {
    let trueView: TrueView
    let condition: Value<Bool>

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            if self.condition.get(from: model) {
                trueView
            } else {
                content
            }
        }
    }
}

#endif
