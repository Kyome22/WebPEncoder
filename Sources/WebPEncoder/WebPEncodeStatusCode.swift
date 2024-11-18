/*
 WebPEncodeStatusCode.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.

*/

import WebPBridge

extension WebPBridge.WebPEncodingError: @retroactive ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        switch UInt32(value) {
        case VP8_ENC_OK.rawValue:
            self = VP8_ENC_OK
        case VP8_ENC_ERROR_OUT_OF_MEMORY.rawValue:
            self = VP8_ENC_ERROR_OUT_OF_MEMORY
        case VP8_ENC_ERROR_BITSTREAM_OUT_OF_MEMORY.rawValue:
            self = VP8_ENC_ERROR_BITSTREAM_OUT_OF_MEMORY
        case VP8_ENC_ERROR_NULL_PARAMETER.rawValue:
            self = VP8_ENC_ERROR_NULL_PARAMETER
        case VP8_ENC_ERROR_INVALID_CONFIGURATION.rawValue:
            self = VP8_ENC_ERROR_INVALID_CONFIGURATION
        case VP8_ENC_ERROR_BAD_DIMENSION.rawValue:
            self = VP8_ENC_ERROR_BAD_DIMENSION
        case VP8_ENC_ERROR_PARTITION0_OVERFLOW.rawValue:
            self = VP8_ENC_ERROR_PARTITION0_OVERFLOW
        case VP8_ENC_ERROR_PARTITION_OVERFLOW.rawValue:
            self = VP8_ENC_ERROR_PARTITION_OVERFLOW
        case VP8_ENC_ERROR_BAD_WRITE.rawValue:
            self = VP8_ENC_ERROR_BAD_WRITE
        case VP8_ENC_ERROR_FILE_TOO_BIG.rawValue:
            self = VP8_ENC_ERROR_FILE_TOO_BIG
        case VP8_ENC_ERROR_USER_ABORT.rawValue:
            self = VP8_ENC_ERROR_USER_ABORT
        case VP8_ENC_ERROR_LAST.rawValue:
            self = VP8_ENC_ERROR_LAST
        default:
            fatalError()
        }
    }
}

public enum WebPEncodeStatusCode: WebPBridge.WebPEncodingError, Sendable {
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
