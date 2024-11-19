/*
 WebPEncoder.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.

*/

import CoreGraphics
import Foundation
import WebPBridge

public struct WebPEncoder: Sendable {
    typealias WebPPictureImporter = @Sendable (UnsafeMutablePointer<WebPPicture>?, UnsafePointer<UInt8>?, Int32) -> Int32

    public init() {}

    private func handlableImage(_ image: CGImage) throws -> (CGImage, CGImage.PixelFormat) {
        switch image.pixelFormat {
        case let .some(pixelFormat):
            return (image, pixelFormat)
        case .none:
            guard let rgbImage = image.sRGB(),
                  let pixelFormat = rgbImage.pixelFormat else {
                throw WebPEncoderError.versionMismatched
            }
            return (rgbImage, pixelFormat)
        }
    }

    private func encode(
        _ dataPointer: UnsafeMutablePointer<UInt8>,
        importer: @escaping WebPPictureImporter,
        config: WebPEncoderConfig,
        originWidth: Int,
        originHeight: Int,
        stride: Int
    ) throws -> Data {
        var config = config.rawValue
        guard WebPValidateConfig(&config) != .zero else {
            throw WebPEncoderError.invalidParameter
        }
        var buffer = WebPMemoryWriter()
        return try withUnsafeMutablePointer(to: &buffer) { pointer in
            var picture = WebPPicture()
            guard WebPPictureInit(&picture) != .zero else {
                throw WebPEncoderError.invalidParameter
            }
            defer {
                WebPPictureFree(&picture)
            }
            picture.use_argb = config.lossless == .zero ? 0 : 1
            picture.width = Int32(originWidth)
            picture.height = Int32(originHeight)
            picture.writer = WebPMemoryWrite
            picture.custom_ptr = UnsafeMutableRawPointer(pointer)
            WebPMemoryWriterInit(pointer)
            guard importer(&picture, dataPointer, Int32(stride)) != .zero else {
                WebPMemoryWriterClear(pointer)
                throw WebPEncoderError.versionMismatched
            }
            guard WebPEncode(&config, &picture) != .zero else {
                WebPMemoryWriterClear(pointer)
                throw WebPEncoderError.encodingError(.init(rawValue: picture.error_code)!)
            }
            return Data(
                bytesNoCopy: pointer.pointee.mem,
                count: pointer.pointee.size,
                deallocator: .free
            )
        }
    }

    public func encode(_ image: CGImage, config: WebPEncoderConfig) throws -> Data {
        let (image, pixelFormat) = try handlableImage(image)
        let importerMethod: WebPPictureImporter = switch pixelFormat {
        case .RGB: WebPPictureImportRGB
        case .BGR: WebPPictureImportBGR
        case .RGBA: WebPPictureImportRGBA
        case .BGRA: WebPPictureImportBGRA
        case .RGBX: WebPPictureImportRGBX
        case .BGRX: WebPPictureImportBGRX
        }
        guard let address = image.baseAddress else {
            throw WebPEncoderError.unexpectedProblemWithPointer
        }
        return try encode(
            address,
            importer: { picturePointer, data, stride in
                importerMethod(picturePointer, data, stride)
            },
            config: config,
            originWidth: Int(image.width),
            originHeight: Int(image.height),
            stride: image.bytesPerRow
        )
    }
}
