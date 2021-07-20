
public protocol NamedType {
    static var type: String { get }
}

extension NamedType {

    public static var type: String {
        String(describing: self)
    }

}
