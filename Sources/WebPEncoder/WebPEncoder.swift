import Foundation
import libwebp

public enum WebPEncoderError: Error {
    case invalidParameter
    case versionMismatched
}

public enum WebPEncodeStatusCode: Int, Error {
    case ok
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

public struct WebPEncoder: Sendable {
    
}
