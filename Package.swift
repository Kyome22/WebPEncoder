// swift-tools-version: 6.1

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "WebPEncoder",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "WebPEncoder",
            targets: ["WebPEncoder"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "libsharpyuv",
            path: "Sources/libsharpyuv.xcframework"
        ),
        .binaryTarget(
            name: "libwebp",
            path: "Sources/libwebp.xcframework"
        ),
        .target(
            name: "WebPBridge",
            dependencies: ["libsharpyuv", "libwebp"],
            publicHeadersPath: "include",
            cSettings: [.headerSearchPath(".")]
        ),
        .target(
            name: "WebPEncoder",
            dependencies: ["WebPBridge"],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "WebPEncoderTests",
            dependencies: ["WebPEncoder"],
            resources: [.process("Resources/sample.jpg")],
            swiftSettings: swiftSettings
        ),
    ]
)
