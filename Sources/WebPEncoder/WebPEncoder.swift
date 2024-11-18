import CoreGraphics
import Foundation
import libwebp

public struct WebPEncoder: Sendable {
    typealias WebPPictureImporter = (UnsafeMutablePointer<WebPPicture>, UnsafeMutablePointer<UInt8>, Int32) -> Int32

    public init() {}

    public func encode(_ image: CGImage, config: WebPEncoderConfig) throws -> Data {
        guard let rgba = image.baseAddress else {
            throw WebPEncoderError.unexpectedProblemWithPointer
        }
        return try encode(
            rgba: rgba,
            config: config,
            originWidth: Int(image.width),
            originHeight: Int(image.height),
            stride: image.bytesPerRow
        )
    }

    func encode(
        rgba: UnsafeMutablePointer<UInt8>,
        config: WebPEncoderConfig,
        originWidth: Int,
        originHeight: Int,
        stride: Int
    ) throws -> Data {
        let importer: WebPPictureImporter = { picturePointer, data, stride in
            WebPPictureImportRGBA(picturePointer, data, stride)
        }
        return try encode(
            rgba,
            importer: importer,
            config: config,
            originWidth: originWidth,
            originHeight: originHeight,
            stride: stride
        )
    }

    private func encode(
        _ dataPointer: UnsafeMutablePointer<UInt8>,
        importer: WebPPictureImporter,
        config: WebPEncoderConfig,
        originWidth: Int,
        originHeight: Int,
        stride: Int
    ) throws -> Data {
        var config = config.rawValue
        guard WebPValidateConfig(&config) != .zero else {
            throw WebPEncoderError.invalidParameter
        }

        var picture = WebPPicture()
        guard WebPPictureInit(&picture) != .zero else {
            throw WebPEncoderError.invalidParameter
        }

        picture.use_argb = config.lossless == .zero ? 0 : 1
        picture.width = Int32(originWidth)
        picture.height = Int32(originHeight)

        guard importer(&picture, dataPointer, Int32(stride)) != .zero else {
            WebPPictureFree(&picture)
            throw WebPEncoderError.versionMismatched
        }

        var buffer = WebPMemoryWriter()
        WebPMemoryWriterInit(&buffer)
        picture.writer = { data, size, picture in
            WebPMemoryWrite(data, size, picture)
        }

        defer {
            WebPPictureFree(&picture)
        }

        try withUnsafeMutableBytes(of: &buffer) { pointer in
            picture.custom_ptr = pointer.baseAddress
            guard WebPEncode(&config, &picture) != .zero else {
                throw WebPEncoderError.encodingError(.init(rawValue: picture.error_code)!)
            }
        }

        return Data(bytesNoCopy: buffer.mem, count: buffer.size, deallocator: .free)
    }
}
