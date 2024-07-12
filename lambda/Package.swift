// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RPNLabmda",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "RPNLabmda", targets: ["RPNLabmda"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", .upToNextMajor(from: "0.5.2")),
    ],
    targets: [
        .executableTarget(
            name: "RPNLabmda",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime")
            ]),
        .testTarget(
            name: "RPNLabmdaTests",
            dependencies: ["RPNLabmda"]),
    ]
)
