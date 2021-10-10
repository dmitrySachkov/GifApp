//
//  Model.swift
//  Get Gif App
//
//  Created by Dmitry Sachkov on 10.10.2021.
//

import Foundation

struct GifsData: Codable {
        let data: [Datum]
    }

    // MARK: - Datum
    struct Datum: Codable {
        let images: Images
    }
      
    // MARK: - Images
    struct Images: Codable {
        let preview: DownsizedSmall
        let previewGIF: The480_WStill

        enum CodingKeys: String, CodingKey {
            case preview
            case previewGIF = "preview_gif"
        }
    }

    // MARK: - The480_WStill
    struct The480_WStill: Codable {
        let height, width, size: String
        let url: String
    }

    // MARK: - DownsizedSmall
    struct DownsizedSmall: Codable {
        let height, width, mp4Size: String
        let mp4: String

        enum CodingKeys: String, CodingKey {
            case height, width
            case mp4Size = "mp4_size"
            case mp4
        }
    }


