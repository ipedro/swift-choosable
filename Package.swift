// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "swift-choosable",
    // Prefer Swift 6 language mode for consumers that build with newer toolchains.
    swiftLanguageVersions: [.v6],
    products: [
        .library(
            name: "Choosable",
            targets: ["Choosable"]),
    ],
    targets: [
        .target(
            name: "Choosable",
            path: "Sources/Choosable"),
        .testTarget(
            name: "ChoosableTests",
            dependencies: ["Choosable"],
            path: "Tests/ChoosableTests"),
    ]
)
