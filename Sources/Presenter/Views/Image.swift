public struct Image: CodableView {
    // MARK: Nested Types

    fileprivate enum Kind: String, Codable {
        case systemName
        case named
        case external
    }

    // MARK: Stored Properties

    fileprivate var identifier: String
    fileprivate var kind: Kind
    fileprivate var isResizable: Bool

    // MARK: Initialization

    private init(kind: Kind, identifier: String, isResizable: Bool) {
        self.kind = kind
        self.identifier = identifier
        self.isResizable = isResizable
    }

    public init(systemName: String) {
        self.kind = .systemName
        self.identifier = systemName
        self.isResizable = false
    }

    public init(external: URL) {
        self.kind = .external
        self.identifier = external.absoluteString
        self.isResizable = false
    }

    public init(named: String) {
        self.kind = .named
        self.identifier = named
        self.isResizable = false
    }

    // MARK: Methods

    public func resizable() -> Image {
        Image(kind: kind, identifier: identifier, isResizable: true)
    }
}

// MARK: - CustomStringConvertible

extension Image: CustomStringConvertible {
    public var description: String {
        "Image(\(kind): \(identifier))"
        + (isResizable ? ".resizable()" : "")
    }
}

// MARK: - View

#if canImport(SwiftUI) && canImport(Combine)

private struct ImageView: SwiftUI.View {
    // MARK: Stored Properties

    var image: Image

    @EnvironmentObject private var model: Model

    @SwiftUI.State private var didStartLoading: Bool = false
    @SwiftUI.State private var loadedImage: SwiftUI.Image?
    @SwiftUI.State private var cancellables = Set<AnyCancellable>()

    // MARK: Views

    var body: some SwiftUI.View {
        DispatchQueue.main.async(execute: load)
        return loadedImage
    }

    // MARK: Helpers

    private func load() {
        guard !didStartLoading else { return }
        didStartLoading = true

        switch image.kind {
        case .systemName:
            #if !os(macOS)
            set(.init(systemName: image.identifier))
            #endif
        case .external:
            guard let url = URL(string: image.identifier) else {
                return assertionFailure("Image could not be loaded from external url: \(image.identifier).")
            }
            loadExternalImage(at: url)
            .sink { $0.map(self.set) }
            .store(in: &cancellables)
        case .named:
            set(.init(image.identifier))
        }
    }

    private func set(_ img: SwiftUI.Image) {
        loadedImage = image.isResizable ? img.resizable() : img
    }
}

#if canImport(UIKit)

extension ImageView {
    private func loadExternalImage(at url: URL) -> AnyPublisher<SwiftUI.Image?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
        .map { response -> SwiftUI.Image? in
            guard let uiImage = UIImage(data: response.data) else {
                return nil
            }
            return SwiftUI.Image(uiImage: uiImage.withRenderingMode(.alwaysOriginal))
        }
        .replaceError(with: nil)
        .eraseToAnyPublisher()
    }
}

#elseif canImport(AppKit)

extension ImageView {
    private func loadExternalImage(at url: URL) -> AnyPublisher<SwiftUI.Image?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
        .map { response -> SwiftUI.Image? in
            guard let nsImage = NSImage(data: response.data) else {
                return nil
            }
            return SwiftUI.Image(nsImage: nsImage)
        }
        .replaceError(with: nil)
        .eraseToAnyPublisher()
    }
}

#endif

extension Image: SwiftUI.View {
    public var body: some SwiftUI.View {
        ImageView(image: self)
    }
}

#endif
