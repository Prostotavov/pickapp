// 
//  FavoritesPresenter.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

class FavoritesPresenter: FavoritesViewOutput, FavoritesInteractorOutput, DBManagerOutput {

    weak var view: FavoritesViewInput!
    weak var coordinator: FavoritesViewCoordinatorOutput!
    var interactor: FavoritesInteractorInput!
    
    func newPhotosLiked() {
        DispatchQueue.main.async {
            let favPhotos = DBManager.shared.getPhotos(fromCollectionWithName: .favorites)
            self.view.reloadCollectionView(with: favPhotos)
        }
    }
    
    func loadView() {
        DispatchQueue.main.async {
            let favPhotos = DBManager.shared.getPhotos(fromCollectionWithName: .favorites)
            self.view.reloadCollectionView(with: favPhotos)
        }
    }
    
    func onImageCellTap(with id: String) {
        coordinator.onImageCell?(id)
    }
    
    func userDidScrollToEnd() {
        
    }
    
}
