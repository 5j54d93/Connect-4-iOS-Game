// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Connect-4-iOS-Game",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Connect-4-iOS-Game",
            targets: ["Connect-4-iOS-Game"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Connect-4-iOS-Game",
            dependencies: []),
        .testTarget(
            name: "Connect-4-iOS-GameTests",
            dependencies: ["Connect-4-iOS-Game"]),
    ]
)
