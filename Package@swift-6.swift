// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "swift-choosable",
    products: [
        .library(
            name: "Choosable",
            targets: ["Choosable"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Choosable",
            path: "Sources/Choosable"),
        .testTarget(
            name: "ChoosableTests",
            dependencies: ["Choosable"],
            path: "Tests/ChoosableTests"),
    ],
    // When built with Swift 6+ toolchains, enable Swift 6 language mode.
    swiftLanguageModes: [.v6]
)
