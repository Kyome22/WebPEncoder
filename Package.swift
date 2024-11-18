// swift-tools-version: 6.0

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
            targets: ["WebPEncoder", "WebPBridge"]
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
        .binaryTarget(
            name: "libwebpdemux",
            path: "Sources/libwebpdemux.xcframework"
        ),
        .binaryTarget(
            name: "libwebpmux",
            path: "Sources/libwebpmux.xcframework"
        ),
        .target(
            name: "WebPBridge",
            dependencies: ["libsharpyuv", "libwebp", "libwebpdemux", "libwebpmux"],
            publicHeadersPath: ".",
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
            swiftSettings: swiftSettings
        ),
    ]
)
