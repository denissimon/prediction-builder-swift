// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PredictionBuilder",
    products: [
        .library(
            name: "PredictionBuilder",
            targets: ["PredictionBuilder"]),
        ],
    targets: [
        .target(
            name: "PredictionBuilder",
            path: "Sources"),
        .testTarget(
            name: "PredictionBuilderTests",
            dependencies: ["PredictionBuilder"],
            path: "Tests"),
        ]
)
