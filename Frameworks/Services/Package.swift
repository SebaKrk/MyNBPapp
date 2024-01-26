// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Services",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Services",
            targets: ["Services"]),
    ],
    dependencies: [
        .package(name: "Commons", path: "../Commons"),
        .package(name: "DataModels", path: "../DataModels"),
        .package(name: "MonumentKit", path: "../MonumentKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Services",
            dependencies: [
                .product(name: "DataModels", package: "DataModels"),
                .product(name: "Commons", package: "Commons"),
                .product(name: "MonumentKit", package: "MonumentKit")
            ]
        ),
        .testTarget(
            name: "ServicesTests",
            dependencies: ["Services"]),
    ]
)
