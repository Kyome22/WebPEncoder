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
            exclude: [
                "libwebp/sharpyuv/Makefile.am",
                "libwebp/sharpyuv/libsharpyuv.pc.in",
                "libwebp/sharpyuv/libsharpyuv.rc",
                "libwebp/src/Makefile.am",
                "libwebp/src/dec/Makefile.am",
                "libwebp/src/demux/Makefile.am",
                "libwebp/src/demux/libwebpdemux.pc.in",
                "libwebp/src/demux/libwebpdemux.rc",
                "libwebp/src/dsp/Makefile.am",
                "libwebp/src/enc/Makefile.am",
                "libwebp/src/libwebp.pc.in",
                "libwebp/src/libwebp.rc",
                "libwebp/src/libwebpdecoder.pc.in",
                "libwebp/src/libwebpdecoder.rc",
                "libwebp/src/mux/Makefile.am",
                "libwebp/src/mux/libwebpmux.pc.in",
                "libwebp/src/mux/libwebpmux.rc",
                "libwebp/src/utils/Makefile.am",
            ],
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
