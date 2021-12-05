internal struct Sheet: CodableViewModifier {
    // MARK: Stored Properties

    let isPresented: Binding<Bool>
    let content: CoderView
}

// MARK: - CustomStringConvertible

extension Sheet: CustomStringConvertible {
    var description: String {
        "sheet(isPresented: \(isPresented), content: \(content))"
    }
}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Sheet {
    func body<Caller: SwiftUI.View>(for caller: Caller) -> View {
        content.modifier(Modifier(caller: caller, isPresented: isPresented))
    }
}

private struct Modifier<Caller: SwiftUI.View>: ViewModifier, SwiftUI.ViewModifier {
    let caller: Caller
    let isPresented: Binding<Bool>

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            caller
                .sheet(isPresented: model.binding(for: self.isPresented)) {
                    content
                        .environmentObject(model)
                }
        }
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func sheet(isPresented: Binding<Bool>, content: View) -> View {
        modifier(Sheet(isPresented: isPresented, content: CoderView(content)))
    }
}
