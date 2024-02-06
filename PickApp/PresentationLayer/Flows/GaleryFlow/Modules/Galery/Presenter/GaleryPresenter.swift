// 
//  GaleryPresenter.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import UIKit

class GaleryPresenter: GaleryViewOutput, GaleryInteractorOutput, StorageGaleryOutput {
    
    weak var view: GaleryViewInput!
    weak var coordinator: GaleryViewCoordinatorOutput!
    var interactor: GaleryInteractorInput!
    
    func onImageCellTap(with id: String) {
        coordinator.onImageCell?(id)
    }
    
    func newPhotosAdded(_ photos: [Photo]) {
        DispatchQueue.main.async {
            self.view.reloadCollectionView(with: photos)
        }
    }
}
