// 
//  FavoritesPresenter.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

class FavoritesPresenter: FavoritesViewOutput, FavoritesInteractorOutput, StorageFavoritesOutput {

    weak var view: FavoritesViewInput!
    weak var coordinator: FavoritesViewCoordinatorOutput!
    var interactor: FavoritesInteractorInput!
    
    func newPhotosLiked(_ photos: [Photo]) {
        DispatchQueue.main.async {
            self.view.reloadCollectionView(with: photos)
        }
    }
}
