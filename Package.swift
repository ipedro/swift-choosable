// swift-tools-version: 5.7.1
import PackageDescription

let package = Package(
    name: "swift-choosable",
    // Exclude top-level non-source files so SwiftPM doesn't warn about unhandled files
    exclude: ["README.md", "LICENSE"],
    products: [
        .library(
            name: "Choosable",
            targets: ["Choosable"]),
    ],
    targets: [
        .target(
            name: "Choosable",
            path: ".",
            exclude: ["README.md", "LICENSE"],
            sources: ["Choosable.swift"]),
        .testTarget(
            name: "ChoosableTests",
            dependencies: ["Choosable"],
            path: ".",
            exclude: ["README.md", "LICENSE"],
            sources: ["ChoosableTests.swift"]),
    ]
)
