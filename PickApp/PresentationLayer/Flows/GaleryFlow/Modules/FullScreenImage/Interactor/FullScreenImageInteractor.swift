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
        } else {
            Storage.shared.likePhoto(with: id)
        }
    }
}
