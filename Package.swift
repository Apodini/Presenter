// swift-tools-version:5.4

import PackageDescription


#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
let exampleTarget: [Target] = [
    .executableTarget(
        name: "Example",
        dependencies: ["Presenter"]
    )
]
let exampleProduct: [Product] = [
    .executable(
        name: "Example",
        targets: ["Example", "Presenter"]
    )
]
#else
let exampleTarget: [Target] = []
let exampleProduct: [Product] = []
#endif


let package = Package(
    name: "Presenter",
    platforms: [.macOS(.v10_15), .watchOS(.v6), .tvOS(.v13), .iOS(.v13)],
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
    ] + exampleProduct,
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
    ] + exampleTarget
)
