/*
 WebPImageHint.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.
 
*/

import libwebp

extension libwebp.WebPImageHint: @retroactive ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        switch UInt32(value) {
        case libwebp.WEBP_HINT_DEFAULT.rawValue:
            self = libwebp.WEBP_HINT_DEFAULT
        case libwebp.WEBP_HINT_PICTURE.rawValue:
            self = libwebp.WEBP_HINT_PICTURE
        case libwebp.WEBP_HINT_PHOTO.rawValue:
            self = libwebp.WEBP_HINT_PHOTO
        case libwebp.WEBP_HINT_GRAPH.rawValue:
            self = libwebp.WEBP_HINT_GRAPH
        default:
            fatalError()
        }
    }
}

public enum WebPImageHint: libwebp.WebPImageHint {
    case `default` = 0
    case picture
    case photo
    case graph
}
