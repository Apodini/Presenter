
extension Chart {

    public enum Style: Codable {

        // MARK: Nested Types

        private enum CodingKeys: String, CodingKey {
            case type
        }

        private enum StyleKind: String, Codable {
            case line
            case area
            case stackedArea
            case column
        }

        // MARK: Cases

        case line(LineStyle)
        case area(AreaStyle)
        case stackedArea(StackedAreaStyle)
        case column(ColumnStyle)

        // MARK: Computed Properties

        private var kind: StyleKind {
            switch self {
            case .line:
                return .line
            case .area:
                return .area
            case .column:
                return .column
            case .stackedArea:
                return .stackedArea
            }
        }

        // MARK: Initialization

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            guard let kind = StyleKind(rawValue: type) else {
                throw DecodingError
                .keyNotFound(
                    CodingKeys.type,
                    .init(codingPath: decoder.codingPath,
                          debugDescription: "Could not find chart style \(type).")
                )
            }
            switch kind {
            case .line:
                self = try .line(LineStyle(from: decoder))
            case .area:
                self = try .area(AreaStyle(from: decoder))
            case .column:
                self = try .column(ColumnStyle(from: decoder))
            case .stackedArea:
                self = try .stackedArea(StackedAreaStyle(from: decoder))
            }
        }

        // MARK: Methods

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(kind, forKey: .type)

            switch self {
            case let .line(style):
                try style.encode(to: encoder)
            case let .area(style):
                try style.encode(to: encoder)
            case let .stackedArea(style):
                try style.encode(to: encoder)
            case let .column(style):
                try style.encode(to: encoder)
            }
        }

    }

}
