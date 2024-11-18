/*
 WebPEncoderConfig.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.
 
*/

import Foundation
import libwebp

public struct WebPEncoderConfig: RawRepresentable {
    public typealias RawValue = WebPConfig

    public var lossless = false
    public var quality: Float // 0~100
    public var method: WebPImageMethod
    public var imageHint: WebPImageHint = .default
    public var targetSize: Int32 = .zero
    public var targetPSNR: Float = .zero
    public var segments: WebPImageSegment
    public var snsStrength: Int32 // 0~100
    public var filterStrength: Int32 // 0~100
    public var filterSharpness: WebPImageSharpness
    public var filterType = false
    public var autoFilter = false
    public var alphaCompression = true
    public var alphaFiltering: WebPImageAlphaFiltering = .fast
    public var alphaQuality: Int32 // 0~100
    public var pass: WebPImageEntropyAnalysisPass
    public var showCompressed: Bool
    public var preprocessing: WebPImagePreprocessing
    public var partitions: WebPImagePartition = .partition0
    public var partitionLimit: Int32 // 0~100
    public var emulateJPEGSize: Bool
    public var threadLevel: Int32
    public var lowMemory: Bool
    public var nearLossless: Int32 = 100 // 0~100
    public var exact: Int32
    public var useDeltaPalette: Bool
    public var useSharpYUV: Bool
    public var qmin: Int32 = 0
    public var qmax: Int32 = 100

    public var rawValue: WebPConfig {
        .init(
            lossless: lossless ? 1 : 0,
            quality: quality,
            method: method.rawValue,
            image_hint: imageHint.rawValue,
            target_size: targetSize,
            target_PSNR: targetPSNR,
            segments: segments.rawValue,
            sns_strength: snsStrength,
            filter_strength: filterStrength,
            filter_sharpness: filterSharpness.rawValue,
            filter_type: filterType ? 1 : 0,
            autofilter: autoFilter ? 1 : 0,
            alpha_compression: alphaCompression ? 1 : 0,
            alpha_filtering: alphaFiltering.rawValue,
            alpha_quality: alphaQuality,
            pass: pass.rawValue,
            show_compressed: showCompressed ? 1 : 0,
            preprocessing: preprocessing.rawValue,
            partitions: partitions.rawValue,
            partition_limit: partitionLimit,
            emulate_jpeg_size: emulateJPEGSize ? 1 : 0,
            thread_level: threadLevel,
            low_memory: lowMemory ? 1 : 0,
            near_lossless: nearLossless,
            exact: exact,
            use_delta_palette: useDeltaPalette ? 1 : 0,
            use_sharp_yuv: useSharpYUV ? 1 : 0,
            qmin: qmin,
            qmax: qmax
        )
    }

    public init?(rawValue config: WebPConfig) {
        lossless = config.lossless != .zero
        quality = config.quality
        method = .init(rawValue: config.method)!
        imageHint = .init(rawValue: config.image_hint)!
        targetSize = config.target_size
        targetPSNR = config.target_PSNR
        segments = .init(rawValue: config.segments)!
        snsStrength = config.sns_strength
        filterStrength = config.filter_strength
        filterSharpness = .init(rawValue: config.filter_sharpness)!
        filterType = config.filter_type != .zero
        autoFilter = config.autofilter != .zero
        alphaCompression = config.alpha_compression != .zero
        alphaFiltering = .init(rawValue: config.alpha_filtering)!
        alphaQuality = config.alpha_quality
        pass = .init(rawValue: config.pass)!
        showCompressed = config.show_compressed != .zero
        preprocessing = .init(rawValue: config.preprocessing)!
        partitions = .init(rawValue: config.partitions)!
        partitionLimit = config.partitions
        emulateJPEGSize = config.emulate_jpeg_size != .zero
        threadLevel = config.thread_level
        lowMemory = config.low_memory != .zero
        nearLossless = config.near_lossless
        exact = config.exact
        useDeltaPalette = config.use_delta_palette != .zero
        useSharpYUV = config.use_sharp_yuv != .zero
        qmin = config.qmin
        qmax = config.qmax
    }

    public static func preset(_ preset: WebPPreset, quality: Float) -> WebPEncoderConfig {
        WebPEncoderConfig(rawValue: preset.config(quality: quality))!
    }
}
