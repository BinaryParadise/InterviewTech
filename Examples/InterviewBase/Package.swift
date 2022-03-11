// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InterviewBase",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "InterviewBase",
            targets: ["InterviewBase"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", .upToNextMinor(from: "3.7.0")),
        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", .upToNextMinor(from: "5.1.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "InterviewBase",
            dependencies: [.product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack"), "SwifterSwift"]),
        .testTarget(
            name: "InterviewBaseTests",
            dependencies: ["InterviewBase"]),
    ]
)
