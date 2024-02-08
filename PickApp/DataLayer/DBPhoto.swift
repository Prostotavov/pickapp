//
//  DBPhoto.swift
//  PickApp
//
//  Created by Roma on 8.02.24.
//

import Foundation
import RealmSwift

class DBPhoto: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var url: String
    @Persisted var imageData: Data
    @Persisted var imagedescription: String
    @Persisted var altDescription: String
    @Persisted var width: Int
    @Persisted var height: Int
    
//    init(id: String, url: String, imageData: Data, imagedescription: String, altDescription: String, width: Int, height: Int) {
//        super.init()
//        self.id = id
//        self.url = url
//        self.imageData = imageData
//        self.imagedescription = imagedescription
//        self.altDescription = altDescription
//        self.width = width
//        self.height = height
//    }
//    
//    init(photo: Photo) {
//        super.init()
//        self.id = photo.id
//        self.url = photo.url
//        self.imageData = photo.image?.pngData() ?? Data()
//        self.imagedescription = photo.description ?? ""
//        self.altDescription = photo.altDescription ?? ""
//        self.width = photo.width ?? 0
//        self.height = photo.height ?? 0
//    }
}
