
public struct If: SwiftUIView {

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

    public init<TrueView: View, FalseView: View>(
        _ condition: Value<Bool>,
        then trueView: TrueView,
        else falseView: FalseView
    ) {
        self.condition = condition
        self.trueView = CoderView(trueView)
        self.falseView = CoderView(falseView)
    }

    public init<TrueView: View>(
        _ condition: Value<Bool>,
        then trueView: TrueView
    ) {
        self.condition = condition
        self.trueView = CoderView(trueView)
        self.falseView = CoderView(Nil())
    }

    public init<FalseView: View>(
        _ condition: Value<Bool>,
        else falseView: FalseView
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

    public var view: some SwiftUI.View {
        ModelView<AnyView> { model in
            if self.condition.get(from: model) {
                return self.trueView.eraseToAnyView()
            } else {
                return self.falseView.eraseToAnyView()
            }
        }
    }

}

#endif
