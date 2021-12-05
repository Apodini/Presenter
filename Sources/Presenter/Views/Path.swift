public struct Path: CodableView {
    // MARK: Nested Types

    private enum ElementKind: String, Codable {
        case moveTo
        case line
        case curve
        case quadCurve
        case closeSubpath
    }

    private struct Element: Codable {
        var kind: ElementKind
        var points: [CGPoint]
    }

    // MARK: Stored Properties

    private var elements: [Element]

    // MARK: Initialization

    public init() {
        self.elements = []
    }

    public init(_ path: (inout Path) -> Void) {
        var newPath = Path()
        path(&newPath)
        self = newPath
    }

    // MARK: Methods

    public mutating func move(to point: CGPoint) {
        elements.append(.init(kind: .moveTo, points: [point]))
    }

    public mutating func addLine(to point: CGPoint) {
        elements.append(.init(kind: .line, points: [point]))
    }

    public mutating func addCurve(to point: CGPoint, control1: CGPoint, control2: CGPoint) {
        elements.append(.init(kind: .curve, points: [control1, control2, point]))
    }

    public mutating func addQuadCurve(to point: CGPoint, control: CGPoint) {
        elements.append(.init(kind: .quadCurve, points: [control, point]))
    }

    public mutating func closeSubpath() {
        elements.append(.init(kind: .closeSubpath, points: []))
    }
}

// MARK: - CustomStringConvertible

extension Path: CustomStringConvertible {
    public var description: String {
        "Path(elements: \(elements))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension Path: SwiftUI.View {
    public var body: some SwiftUI.View {
        SwiftUI.Path { path in
            for element in elements {
                switch element.kind {
                case .moveTo:
                    path.move(to: element.points[0])
                case .line:
                    path.addLine(to: element.points[0])
                case .curve:
                    path.addCurve(to: element.points[2],
                                  control1: element.points[0],
                                  control2: element.points[1])
                case .quadCurve:
                    path.addQuadCurve(to: element.points[1],
                                      control: element.points[0])
                case .closeSubpath:
                    path.closeSubpath()
                }
            }
        }
    }
}

#endif
