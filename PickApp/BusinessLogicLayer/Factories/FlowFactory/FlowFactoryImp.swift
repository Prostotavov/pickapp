//
//  FlowFactoryImp.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

import UIKit.UIViewController

class FlowFactoryImp {
    
    static let defaultFactory = FlowFactoryImp()
}

extension FlowFactoryImp: GaleryFlowFactory {
    
    func produceGaleryOutput() -> GaleryViewCoordinatorOutput {
        return GaleryViewController()
    }
    
    func produceFullScreenImageOutput(with id: String) -> FullScreenImageViewCoordinatorOutput? {
        if let photo = TempImageStorage.shared.getPhoto(with: id) {
            return FullScreenImageViewController(photo: photo)
        }
        if let dbPhoto = DatabaseManagerImp().getPhoto(withId: id, fromCollectionWithName: .favorites) {
            let photo = Photo(dbPhoto: dbPhoto)
            return FullScreenImageViewController(photo: photo)
        }
        return nil
    }
}

extension FlowFactoryImp: FavoritesFlowFactory {
    
    func produceFavoritesOutput() -> FavoritesViewCoordinatorOutput {
        return FavoritesViewController()
    }
}
