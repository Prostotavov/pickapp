//
//  Photo.swift
//  PickApp
//
//  Created by Roma on 3.02.24.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id, slug, description, altDescription: String?
    let urls: PhotoURL?

    enum CodingKeys: String, CodingKey {
        case id, slug, description, urls
        case altDescription = "alt_description"
    }
}

// MARK: - PhotoURL
struct PhotoURL: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
