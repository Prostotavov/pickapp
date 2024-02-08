//
//  Photo.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation
import UIKit

struct Photo {
    let id, url: String
    var image: UIImage?
    let description, altDescription: String?
    let width, height: Int?
    
    init(id: String, url: String, image: UIImage?, description: String?, altDescription: String?, width: Int?, height: Int?) {
        self.id = id
        self.url = url
        self.image = image
        self.description = description
        self.altDescription = altDescription
        self.width = width
        self.height = height
    }
    
    init(photoResponse: PhotoResponse, image: UIImage?) {
        self.id = photoResponse.id ?? ""
        self.url = photoResponse.urls?.regular ?? ""
        self.image = image ?? UIImage()
        self.description = photoResponse.description
        self.altDescription = photoResponse.altDescription
        self.width = photoResponse.width
        self.height = photoResponse.height
    }
    
    init(dbPhoto: DBPhoto) {
        self.id = dbPhoto.id
        self.url = dbPhoto.url
        self.image = UIImage(data: dbPhoto.imageData)
        self.description = dbPhoto.imagedescription
        self.altDescription = dbPhoto.altDescription
        self.width = dbPhoto.width
        self.height = dbPhoto.height
    }
    
    init() {
        self.id = ""
        self.url = ""
        self.image = UIImage()
        self.description = ""
        self.altDescription = ""
        self.width = 0
        self.height = 0
    }
}
