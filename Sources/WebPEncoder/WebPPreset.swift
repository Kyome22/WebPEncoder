/*
 WebPPreset.swift
 WebPEncoder

 Created by Takuto Nakamura on 2024/11/18.
 
*/

import libwebp

public enum WebPPreset {
    case `default`
    case picture
    case photo
    case drawing
    case icon
    case text

    func config(quality: Float, multithread: Bool) -> WebPConfig {
        let quality = min(100, max(0, 100 * quality))
        var config = WebPConfig()
        let preset = switch self {
        case .default: WEBP_PRESET_DEFAULT
        case .picture: WEBP_PRESET_PICTURE
        case .photo:   WEBP_PRESET_PHOTO
        case .drawing: WEBP_PRESET_DRAWING
        case .icon:    WEBP_PRESET_ICON
        case .text:    WEBP_PRESET_TEXT
        }
        WebPConfigPreset(&config, preset, quality)
        config.thread_level = multithread ? 1 : 0
        return config
    }
}
