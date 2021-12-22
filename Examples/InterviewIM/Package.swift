// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InterviewIM",
    platforms: [.iOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "InterviewIM",
            targets: ["InterviewIM"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "InterviewBase", path: "../InterviewBase"),
        .package(name: "InterviewUIComponent", path: "../InterviewUIComponent"),
        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", .upToNextMinor(from: "5.1.0")),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", .upToNextMinor(from: "3.7.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMinor(from: "5.0.0")),
        .package(url: "https://github.com/ccgus/fmdb.git", .upToNextMinor(from: "2.7.0")),
        .package(url: "https://github.com/CoderMJLee/MJRefresh.git", .upToNextMinor(from: "3.7.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "InterviewIM",
            dependencies: [.product(name: "FMDB", package: "fmdb"),
                           "SnapKit",
                           "SwifterSwift",
                           "InterviewUIComponent",
                           "MJRefresh",
                           .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack")],
            resources: [.process("smsCorpus_zh_2015.03.09.json")]
        ),
        .testTarget(
            name: "InterviewIMTests",
            dependencies: ["InterviewIM"]),
    ]
)
