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
        if Storage.shared.getLikedPhotos().contains(where: {$0.id == id}) {
            Storage.shared.unlikePhoto(with: id)
            guard let photo = Storage.shared.getPhoto(with: id) else {
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
        } else {
//            Storage.shared.likePhoto(with: id)
            DBManager.shared.deletePhoto(withId: id, fromCollectionWithName: .favorites)
        }
    }
}
