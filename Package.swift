// swift-tools-version:5.10
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
    ]
    ,
    // Advertise source compatibility with Swift 5 and Swift 6.
    swiftLanguageVersions: [.v5, .v6]
)
