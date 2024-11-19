/*
 CGImage+Extension.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.
 
*/

import CoreGraphics

extension CGImage {
    var baseAddress: UnsafeMutablePointer<UInt8>? {
        guard let dataProvider = dataProvider,
              let data = dataProvider.data else {
            return nil
        }
        let mutableData = data as! CFMutableData
        return CFDataGetMutableBytePtr(mutableData)
    }

    var hasAlpha: Bool {
        ![.none, .noneSkipFirst, .noneSkipLast].contains(alphaInfo)
    }

    enum ByteOrder {
        case little
        case big
        case unknown

        init(byteOrderInfo: CGImageByteOrderInfo) {
            self = switch byteOrderInfo {
            case .order16Little, .order32Little: .little
            case .order16Big, .order32Big: .big
            case .orderMask, .orderDefault: .unknown
            @unknown default: fatalError()
            }
        }
    }

    enum AlphaOrder {
        case first
        case last
        case only
        case none

        init(alphaInfo: CGImageAlphaInfo) {
            self = switch alphaInfo {
            case .premultipliedFirst, .first, .noneSkipFirst: .first
            case .premultipliedLast, .last, .noneSkipLast: .last
            case .none: .none
            case .alphaOnly: .only
            @unknown default: fatalError()
            }
        }
    }

    // Encodableなものだけに絞る
    enum PixelFormat {
        case RGB
        case BGR
        case RGBA
        case BGRA
        case RGBX
        case BGRX
    }

    var pixelFormat: PixelFormat? {
        guard let numberOfComponents = colorSpace?.numberOfComponents, numberOfComponents == 3 else {
            return nil
        }
        let byteOrder = ByteOrder(byteOrderInfo: byteOrderInfo)
        let alphaOrder = AlphaOrder(alphaInfo: alphaInfo)
        return switch (byteOrder, alphaOrder) {
        case (.little, .first): hasAlpha ? .BGRA : .BGRX
        case (.little, .none): .BGR
        case (.big, .last): hasAlpha ? .RGBA : .RGBX
        case (.big, .none): .RGB
        default: nil
        }
    }

    func sRGB() -> CGImage? {
        let w = Int(width)
        let h = Int(height)
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
            .union(.byteOrder32Big)
        guard let context = CGContext(
            data: nil,
            width: w,
            height: h,
            bitsPerComponent: 8,
            bytesPerRow: 4 * w,
            space: CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: bitmapInfo.rawValue
        ) else {
            return nil
        }
        context.draw(self, in: CGRect(x: 0, y: 0, width: w, height: h))
        return context.makeImage()
    }
}
