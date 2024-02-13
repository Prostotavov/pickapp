// 
//  FavoritesPresenter.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

class FavoritesPresenter: FavoritesViewOutput, FavoritesInteractorOutput, DatabaseManagerOutput {

    weak var view: FavoritesViewInput!
    weak var coordinator: FavoritesViewCoordinatorOutput!
    var interactor: FavoritesInteractorInput!
    var databaseManager: DatabaseManager!
    
    func newPhotosLiked() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let favPhotos = self.databaseManager.getPhotos(fromCollectionWithName: .favorites)
            self.view.reloadCollectionView(with: favPhotos)
        }
    }
    
    func loadView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let favPhotos = self.databaseManager.getPhotos(fromCollectionWithName: .favorites)
            self.view.reloadCollectionView(with: favPhotos)
        }
    }
    
    func onImageCellTap(with content: Photo) {
        coordinator.onImageCell?(content)
    }
    
    func userDidScrollToEnd() {
        
    }
    
}
