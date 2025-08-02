import AppKit
import Testing
@testable import WebPEncoder

struct WebPEncoderTests {
    @Test
    func encoder() throws {
        let sut = WebPEncoder()
        guard let url = Bundle.module.url(forResource: "sample", withExtension: "jpg"),
              let nsImage = NSImage(contentsOf: url),
              let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            Issue.record()
            return
        }
        #expect(throws: Never.self) {
            try sut.encode(cgImage, config: .preset(.picture, quality: 0.8, multithread: false))
        }
    }
}
