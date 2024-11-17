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
            targets: ["WebPEncoder"]
        ),
    ],
    targets: [
        .target(
            name: "libwebp",
            path: ".",
            sources: [
                "libwebp/src", 
                "libwebp/sharpyuv",
            ],
            publicHeadersPath: "Headers",
            cSettings: [
                .headerSearchPath("libwebp"),
            ]
        ),
        .target(
            name: "WebPEncoder",
            dependencies: ["libwebp"],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "WebPEncoderTests",
            dependencies: ["WebPEncoder"],
            swiftSettings: swiftSettings
        ),
    ]
)
