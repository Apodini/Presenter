// swift-tools-version:5.4

import PackageDescription

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

let package = Package(
    name: "Presenter",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "Presenter",
            targets: ["Presenter"]
        ),
        .library(
            name: "ChartPresenter",
            targets: ["ChartPresenter"]
        ),
        .library(
            name: "MetricPresenter",
            targets: ["MetricPresenter"]
        ),
        .library(
            name: "TracePresenter",
            targets: ["TracePresenter"]
        ),
        .executable(
            name: "Example",
            targets: ["Example", "Presenter"]
        )
    ],
    dependencies: [
        .package(name: "Charts", url: "https://github.com/spacenation/swiftui-charts.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Presenter",
            dependencies: []
        ),
        .target(
            name: "ChartPresenter",
            dependencies: ["Presenter", "Charts"]
        ),
        .target(
            name: "MetricPresenter",
            dependencies: ["ChartPresenter"]
        ),
        .target(
            name: "TracePresenter",
            dependencies: ["Presenter"]
        ),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["Presenter", "ChartPresenter", "MetricPresenter", "TracePresenter"]
        ),
        .executableTarget(
            name: "Example",
            dependencies: ["Presenter"]
        )
    ]
)

#else

let package = Package(
    name: "Presenter",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "Presenter",
            targets: ["Presenter"]
        ),
        .library(
            name: "ChartPresenter",
            targets: ["ChartPresenter"]
        ),
        .library(
            name: "MetricPresenter",
            targets: ["MetricPresenter"]
        ),
        .library(
            name: "TracePresenter",
            targets: ["TracePresenter"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Presenter",
            dependencies: []
        ),
        .target(
            name: "ChartPresenter",
            dependencies: ["Presenter"]
        ),
        .target(
            name: "MetricPresenter",
            dependencies: ["ChartPresenter"]
        ),
        .target(
            name: "TracePresenter",
            dependencies: ["Presenter"]
        ),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["Presenter", "ChartPresenter", "MetricPresenter", "TracePresenter"]
        )
    ]
)

#endif
