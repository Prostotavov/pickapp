// 
//  FullScreenImagePresenter.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation

class FullScreenImagePresenter: FullScreenImageViewOutput, FullScreenImageInteractorOutput {

    weak var view: FullScreenImageViewInput!
    weak var coordinator: FullScreenImageViewCoordinatorOutput!
    var interactor: FullScreenImageInteractorInput!
    
    func onBackPressed() {
        coordinator.onBack?()
    }
    
    func onLikePressed(for photo: Photo) {
        interactor.likePhoto(photo: photo)
    }
}
