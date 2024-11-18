/*
 WebPImageHint.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.

*/

import WebPBridge

extension WebPBridge.WebPImageHint: @retroactive ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        switch UInt32(value) {
        case WEBP_HINT_DEFAULT.rawValue:
            self = WEBP_HINT_DEFAULT
        case WEBP_HINT_PICTURE.rawValue:
            self = WEBP_HINT_PICTURE
        case WEBP_HINT_PHOTO.rawValue:
            self = WEBP_HINT_PHOTO
        case WEBP_HINT_GRAPH.rawValue:
            self = WEBP_HINT_GRAPH
        default:
            fatalError()
        }
    }
}

public enum WebPImageHint: WebPBridge.WebPImageHint {
    case `default` = 0
    case picture
    case photo
    case graph
}
