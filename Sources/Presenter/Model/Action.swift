
public protocol Action: Codable {
    static var type: String { get }

    #if canImport(SwiftUI)
    func perform(on model: Model)
    #endif
}

extension Action {

    public static var type: String {
        String(describing: Self.self)
    }

}
