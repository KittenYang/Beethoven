// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Beethoven",
    platforms: [.iOS(.v8)],
    products: [
        .library(
            name: "Beethoven",
            targets: ["Beethoven"]),
    ],
    dependencies: [
        .package(name: "Pitchy", url: "https://github.com/KittenYang/Pitchy.git", .branch("master"))
    ],
    targets: [
        .target(name: "Beethoven", dependencies: ["Pitchy"], path: "Source")
    ]
)

