// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Yield",
    platforms: [.macOS(.v15),
                .iOS(.v17)],
    products: [
        .library(name: "Yield",
                 targets: ["Yield"]),
    ],
    dependencies: [
        .package(path: "../Deltille"),
    ],
    targets: [
        .target(name: "Yield",
                dependencies: ["Deltille"],
                resources: [.process("Assets.xcassets")])
    ]
)
