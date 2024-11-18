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
}
