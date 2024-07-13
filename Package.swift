// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Yield",
    platforms: [.macOS(.v14),
                .iOS(.v17)],
    products: [
        .library(name: "Yield",
                 targets: ["Yield"]),
    ],
    dependencies: [
        .package(path: "../Bivouac"),
        .package(path: "../Deltille"),
        .package(path: "../Furrow"),
        .package(url: "git@github.com:nicklockwood/Euclid.git",
                 branch: "main"),
        .package(path: "../Regolith"),
        .package(path: "../Verdure")
    ],
    targets: [
        .target(name: "Yield",
                dependencies: ["Bivouac",
                               "Deltille",
                               "Euclid",
                               "Furrow",
                               "Regolith",
                               "Verdure"],
                resources: [.process("Assets")]),
    ]
)
