/*
 WebPEncodeStatusCode.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.
 
*/

import libwebp

extension libwebp.WebPEncodingError: @retroactive ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        switch UInt32(value) {
        case libwebp.VP8_ENC_OK.rawValue:
            self = libwebp.VP8_ENC_OK
        case libwebp.VP8_ENC_ERROR_OUT_OF_MEMORY.rawValue:
            self = libwebp.VP8_ENC_ERROR_OUT_OF_MEMORY
        case libwebp.VP8_ENC_ERROR_BITSTREAM_OUT_OF_MEMORY.rawValue:
            self = libwebp.VP8_ENC_ERROR_BITSTREAM_OUT_OF_MEMORY
        case libwebp.VP8_ENC_ERROR_NULL_PARAMETER.rawValue:
            self = libwebp.VP8_ENC_ERROR_NULL_PARAMETER
        case libwebp.VP8_ENC_ERROR_INVALID_CONFIGURATION.rawValue:
            self = libwebp.VP8_ENC_ERROR_INVALID_CONFIGURATION
        case libwebp.VP8_ENC_ERROR_BAD_DIMENSION.rawValue:
            self = libwebp.VP8_ENC_ERROR_BAD_DIMENSION
        case libwebp.VP8_ENC_ERROR_PARTITION0_OVERFLOW.rawValue:
            self = libwebp.VP8_ENC_ERROR_PARTITION0_OVERFLOW
        case libwebp.VP8_ENC_ERROR_PARTITION_OVERFLOW.rawValue:
            self = libwebp.VP8_ENC_ERROR_PARTITION_OVERFLOW
        case libwebp.VP8_ENC_ERROR_BAD_WRITE.rawValue:
            self = libwebp.VP8_ENC_ERROR_BAD_WRITE
        case libwebp.VP8_ENC_ERROR_FILE_TOO_BIG.rawValue:
            self = libwebp.VP8_ENC_ERROR_FILE_TOO_BIG
        case libwebp.VP8_ENC_ERROR_USER_ABORT.rawValue:
            self = libwebp.VP8_ENC_ERROR_USER_ABORT
        case libwebp.VP8_ENC_ERROR_LAST.rawValue:
            self = libwebp.VP8_ENC_ERROR_LAST
        default:
            fatalError()
        }
    }
}

public enum WebPEncodeStatusCode: libwebp.WebPEncodingError, Sendable {
    case ok = 0
    case outOfMemory
    case bitstreamOutOfMemory
    case nullParameter
    case invalidConfiguration
    case badDimension
    case partition0Overflow
    case partitionOverflow
    case badWrite
    case fileTooBig
    case userAbort
    case last
}
