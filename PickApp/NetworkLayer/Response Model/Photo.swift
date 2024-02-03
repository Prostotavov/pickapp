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

    enum CodingKeys: String, CodingKey {
        case id, slug, description
        case altDescription = "alt_description"
    }
}
