
#if canImport(SwiftUI) && canImport(Combine)

public struct ServedView<Placeholder: SwiftUI.View>: SwiftUI.View {

    // MARK: Nested Types

    public enum PlaceholderState {
        case empty
        case loading
        case failure(Error)
    }

    private enum State {
        case empty
        case loading
        case success(AnyView)
        case failure(Error)
    }

    // MARK: Stored Properties

    private let publisher: AnyPublisher<AnyView, Error>?
    private let placeholder: (PlaceholderState) -> Placeholder
    @ObservedObject private var model: Model

    // MARK: State

    @SwiftUI.State private var state = State.empty
    @SwiftUI.State private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization

    public init(
        url: URL?,
        session: URLSession = .shared,
        model: Model,
        @SwiftUI.ViewBuilder placeholder: @escaping (PlaceholderState) -> Placeholder
    ) {

        guard let url = url else {
            self.init(
                dataPublisher: nil as AnyPublisher<Data, Error>?,
                model: model,
                placeholder: placeholder
            )
            return
        }

        if url.isFileURL {
            self.init(
                dataPublisher: Just(url).tryMap { try Data(contentsOf: $0) },
                model: model,
                placeholder: placeholder
            )
        } else {
            self.init(
                dataPublisher: session.dataTaskPublisher(for: url)
                    .tryMap { data, response -> Data in
                        guard let httpResponse = response as? HTTPURLResponse,
                              httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                        return data
                    },
                model: model,
                placeholder: placeholder
            )
        }
    }

    public init<P: Publisher>(
        dataPublisher: P?,
        model: Model,
        @SwiftUI.ViewBuilder placeholder: @escaping (PlaceholderState) -> Placeholder
    ) where P.Output == Data {

        let viewPublisher = dataPublisher?
            .tryMap { try Presenter.decode(from: $0).eraseToAnyView() }

        self.init(
            viewPublisher: viewPublisher,
            model: model,
            placeholder: placeholder
        )
    }

    public init<P: Publisher>(
        viewPublisher: P?,
        model: Model,
        @SwiftUI.ViewBuilder placeholder: @escaping (PlaceholderState) -> Placeholder
    ) where P.Output == AnyView {

        self.publisher = viewPublisher?
            .mapError { $0 as Error }
            .eraseToAnyPublisher()

        self.model = model
        self.placeholder = placeholder
    }

    // MARK: Views

    public var body: some SwiftUI.View {
        content
            .environmentObject(model)
            .onAppear(perform: load)
    }

    @SwiftUI.ViewBuilder
    private var content: some SwiftUI.View {
        switch state {
        case .empty:
            placeholder(.empty)
        case .loading:
            placeholder(.loading)
        case let .success(view):
            view
        case let .failure(error):
            placeholder(.failure(error))
        }
    }

    // MARK: Helpers

    private func load() {
        switch state {
        case .success, .failure, .loading:
            return
        case .empty:
            guard let publisher = publisher else {
                return
            }

            state = .loading

            publisher
                .map { State.success($0) }
                .catch { Just(.failure($0)) }
                .receive(on: DispatchQueue.main)
                .assign(to: \.state, on: self)
                .store(in: &cancellables)
        }
    }

}

#endif
