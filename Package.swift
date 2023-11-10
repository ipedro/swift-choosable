// swift-tools-version: 5.7.1
import PackageDescription

let package = Package(
    name: "swift-choosable",
    products: [
        .library(
            name: "Choosable",
            targets: ["Choosable"]),
    ],
    targets: [
        .target(
            name: "Choosable",
            path: ".",
            sources: ["Choosable.swift"]),
        .testTarget(
            name: "ChoosableTests",
            dependencies: ["Choosable"],
            path: ".",
            sources: ["ChoosableTests.swift"]),
    ]
)
