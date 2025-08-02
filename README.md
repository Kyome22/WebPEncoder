# WebPEncoder

Swift WebP Encoder

This library using [libwebp](https://github.com/webmproject/libwebp).

## Requirements

- Development with Xcode 16.0+
- Written in Swift 6.0
- swift-tools-version: 6.0
- Compatible with macOS 14.0+

## Usage

```swift
import AppKit
import WebPEncoder

guard let url = Bundle.module.url(forResource: "sample", withExtension: "jpg"),
      let nsImage = NSImage(contentsOf: url),
      let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
        return
}
do {
    let webpData = try WebPEncoder().encode(cgImage, config: .preset(.picture, quality: 0.8, multithread: false))
    webpData.write(to: saveURL)
} catch {
    print(error.localizedDescription)
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.
