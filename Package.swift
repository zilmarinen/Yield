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
        .package(path: "../Alluvium"),
        .package(path: "../Cobble"),
        .package(path: "../Deltille"),
        .package(path: "../Lintel"),
        .package(path: "../Newel"),
        .package(path: "../Verdure"),
        .package(url: "git@github.com:3Squared/PeakOperation.git",
                 branch: "master")
    ],
    targets: [
        .executableTarget(name: "Thresher",
                          dependencies: ["Alluvium",
                                         "Cobble",
                                         "Deltille",
                                         "Lintel",
                                         "Newel",
                                         "PeakOperation",
                                         "Verdure",
                                         "Yield"],
                          path: "Sources/Thresher"),
        .target(name: "Yield",
                dependencies: ["Alluvium",
                               "Cobble",
                               "Deltille",
                               "Lintel",
                               "Newel",
                               "Verdure"],
                resources: [.process("Assets.xcassets")])
    ]
)
