
internal struct Sheet: AnyViewModifying {

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

extension Sheet: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            content
            .sheet(isPresented: model.binding(for: self.isPresented)) {
                self.content.eraseToAnyView()
                .environmentObject(model)
            }
        }
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func sheet<Content: View>(isPresented: Binding<Bool>, content: Content) -> some View {
        modified(using: Sheet(isPresented: isPresented, content: CoderView(content)))
    }

}
