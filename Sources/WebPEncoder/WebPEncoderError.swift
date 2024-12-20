/*
 WebPEncoderError.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.

*/

import WebPBridge

public enum WebPEncoderError: Error {
    case invalidParameter
    case versionMismatched
    case unexpectedProblemWithPointer
    case encodingError(WebPEncodeStatusCode)
}
