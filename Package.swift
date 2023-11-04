// swift-tools-version: 5.9
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
            name: "Choosable"),
        .testTarget(
            name: "ChoosableTests",
            dependencies: ["Choosable"]),
    ]
)
