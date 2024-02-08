//
//  FavoritesFactory.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol FavoritesFlowFactory {
    
    func produceFavoritesOutput() -> FavoritesViewCoordinatorOutput
    func produceFullScreenImageOutput(with id: String) -> FullScreenImageViewCoordinatorOutput?
}
