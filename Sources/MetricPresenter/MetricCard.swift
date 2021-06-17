
struct MetricCard: AnyViewModifying {

    // MARK: Stored Properties

    var title: String
    var subtitle: String

}

#if canImport(SwiftUI)

extension MetricCard: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.VStack(alignment: .leading) {
            SwiftUI.Text(title)
                .font(.headline)
            SwiftUI.Text(subtitle)
                .font(.caption)
                .opacity(0.5)

            SwiftUI.HStack {
                SwiftUI.Spacer()
                SwiftUI.VStack {
                    SwiftUI.Spacer()
                    content
                    SwiftUI.Spacer()
                }
                SwiftUI.Spacer()
            }
            .aspectRatio(2, contentMode: .fit)
            .frame(maxWidth: .infinity)
        }
        .padding(16)
        .card()
        .padding(8)
    }

}

#endif

extension View {

    public func metricCard(title: String, subtitle: String) -> some View {
        modified(using: MetricCard(title: title, subtitle: subtitle))
    }

}
