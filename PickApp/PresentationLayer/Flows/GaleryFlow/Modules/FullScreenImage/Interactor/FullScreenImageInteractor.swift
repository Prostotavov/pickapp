// 
//  FullScreenImageInteractor.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation

class FullScreenImageInteractor: FullScreenImageInteractorInput {
    
    weak var output: FullScreenImageInteractorOutput!
    
    func likePhoto(with id: String) {
        if DBManager.shared.isExistPhoto(withId: id, inCollectionWithName: .favorites) {
            DBManager.shared.deletePhoto(withId: id, fromCollectionWithName: .favorites)
        } else {
            guard let photo = TempImageStorage.shared.getPhoto(with: id) else {
                return
            }
            let dbPhoto = DBPhoto()
            dbPhoto.id = photo.id
            dbPhoto.url = photo.url
            dbPhoto.imageData = photo.image?.pngData() ?? Data()
            dbPhoto.imagedescription = photo.description ?? ""
            dbPhoto.altDescription = photo.altDescription ?? ""
            dbPhoto.width = photo.width ?? 0
            dbPhoto.height = photo.height ?? 0
            DBManager.shared.addPhoto(dbPhoto, toCollectionWithName: .favorites)
        }
    }
}
