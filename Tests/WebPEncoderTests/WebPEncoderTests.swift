import AppKit
import XCTest
@testable import WebPEncoder

final class WebPEncoderTests: XCTestCase {
    func test_encoder() throws {
        let sut = WebPEncoder()
        guard let url = Bundle.module.url(forResource: "sample", withExtension: "jpg"),
              let nsImage = NSImage(contentsOf: url),
              let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try sut.encode(cgImage, config: .preset(.picture, quality: 0.8, multithread: false)))
    }
}
