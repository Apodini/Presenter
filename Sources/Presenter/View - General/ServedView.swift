
#if canImport(SwiftUI) && canImport(Combine)

public struct ServedView: SwiftUI.View {

    // MARK: Stored Properties

    public let url: URL?
    @ObservedObject var model: Model

    // MARK: State

    @SwiftUI.State private var didStartLoading = false
    @SwiftUI.State private var view: AnyView?
    @SwiftUI.State private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization

    public init(url: URL?, model: Model) {
        self.url = url
        self.model = model
    }

    // MARK: Views

    public var body: some SwiftUI.View {
        view
        .environmentObject(model)
        .onAppear(perform: load)
    }

    // MARK: Helpers

    private func load() {
        guard let url = url, !didStartLoading else { return }
        didStartLoading = true
        guard !url.isFileURL else {
            if let data = try? Data(contentsOf: url),
                let view = try? Presenter.decode(from: data) {
                    self.view = view.eraseToAnyView()
            }
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: CoderView.self, decoder: JSONDecoder())
        .map(Optional.some)
        .replaceError(with: nil)
        .map { $0?.eraseToAnyView() }
        .receive(on: DispatchQueue.main)
        .assign(to: \.view, on: self)
        .store(in: &cancellables)
    }

}

#endif
