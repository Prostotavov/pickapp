// 
//  FullScreenImageInteractor.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation

class FullScreenImageInteractor: FullScreenImageInteractorInput {
    
    weak var output: FullScreenImageInteractorOutput!
    var databaseManager: DatabaseManager!
    
    func likePhoto(photo: Photo) {
        if databaseManager.isExistPhoto(withId: photo.id, inCollectionWithName: .favorites) {
            databaseManager.deletePhoto(withId: photo.id, fromCollectionWithName: .favorites)
        } else {
            let dbPhoto = DBPhoto()
            dbPhoto.id = photo.id
            dbPhoto.url = photo.url
            dbPhoto.imageData = photo.image?.pngData() ?? Data()
            dbPhoto.imagedescription = photo.description ?? ""
            dbPhoto.altDescription = photo.altDescription ?? ""
            dbPhoto.width = photo.width ?? 0
            dbPhoto.height = photo.height ?? 0
            databaseManager.addPhoto(dbPhoto, toCollectionWithName: .favorites)
        }
    }
}
