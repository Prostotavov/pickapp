// 
//  FavoritesPresenter.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

class FavoritesPresenter: FavoritesViewOutput, FavoritesInteractorOutput {

    weak var view: FavoritesViewInput!
    weak var coordinator: FavoritesViewCoordinatorOutput!
    var interactor: FavoritesInteractorInput!
    
}
