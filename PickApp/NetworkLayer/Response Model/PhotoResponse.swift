//
//  PhotoResponse.swift
//  PickApp
//
//  Created by Roma on 3.02.24.
//

import Foundation

// MARK: - PhotoResponse
struct PhotoResponse: Codable {
    let id, description, altDescription: String?
    let urls: PhotoURL?
    let width, height: Int?

    enum CodingKeys: String, CodingKey {
        case id, description, urls, width,height
        case altDescription = "alt_description"
    }
}

// MARK: - PhotoURL
struct PhotoURL: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
