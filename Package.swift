// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Presenter",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "Presenter",
            targets: ["Presenter"]),
        .library(
            name: "ChartPresenter",
            targets: ["ChartPresenter"]),
        .executable(
            name: "Example",
            targets: ["Example"]),
    ],
    dependencies: [
        .package(url: "https://github.com/spacenation/swiftui-charts", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Presenter",
            dependencies: []),
        .target(
            name: "ChartPresenter",
            dependencies: [
                .product(name: "Charts", package: "swiftui-charts", condition: .when(platforms: [.macOS, .macCatalyst, .iOS, .watchOS, .tvOS])),
                .target(name: "Presenter"),
            ]),
        .executableTarget(
            name: "Example",
            dependencies: ["Presenter"]),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["Presenter"]),
    ])
