#if canImport(SwiftUI)

protocol SizePreferenceKey: PreferenceKey where Value == CGSize {}

extension SizePreferenceKey {
    static var defaultValue: CGSize { .zero }

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let next = nextValue()
        guard next != .zero && next != value else { return }
        value = next
    }
}

extension SwiftUI.View {
    func size<Key: SizePreferenceKey>(in key: Key.Type) -> some SwiftUI.View {
        background(
            GeometryReader { geometry in
                SwiftUI.Color.clear.preference(key: Key.self, value: geometry.size)
            }
        )
    }
}

#endif
