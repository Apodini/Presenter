// swift-tools-version:5.4

import PackageDescription

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

let package = Package(
    name: "Presenter",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "Presenter",
            targets: ["Presenter"]),
        .executable(
            name: "Example",
            targets: ["Example"])
    ],
    targets: [
        .target(
            name: "Presenter",
            dependencies: []),
        .executableTarget(
            name: "Example",
            dependencies: ["Presenter"]),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["Presenter"]),
    ]
)

#else

let package = Package(
    name: "Presenter",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "Presenter",
            targets: ["Presenter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Presenter",
            dependencies: []),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["Presenter"]),
    ]
)

#endif
