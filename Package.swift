// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExpoFpIndoorAtlas",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "ExpoFpIndoorAtlas",
            targets: ["ExpoFpIndoorAtlas"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/expofp/expofp-sdk-ios", from: "5.3.0"),
        .package(url: "https://github.com/IndoorAtlas/ios-spm", exact: "3.7.1"),
    ],
    targets: [
        .target(
            name: "ExpoFpIndoorAtlas",
            dependencies: [
                .product(name: "ExpoFP", package: "expofp-sdk-ios"),
                .product(name: "IndoorAtlas", package: "ios-spm"),
            ],
            path: "ExpoFpIndoorAtlas"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
