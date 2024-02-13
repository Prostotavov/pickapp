// 
//  GaleryPresenter.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import UIKit

class GaleryPresenter: GaleryViewOutput, GaleryInteractorOutput, StorageOutput {
    
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
    
    func userDidScrollToEnd() {
        ImageLoader.shared.loadMorePhotos()
    }
    
    func loadView() {
        ImageLoader.shared.loadImages()
    }
    
    func loadImage(at indexPath: IndexPath, from url: URL) {
        interactor.loadImage(from: url, completionHandler: { [weak self] imageData in
            DispatchQueue.main.async {
                let image = UIImage(data: imageData ?? Data())
                self?.view?.updateImage(at: indexPath, with: image)
            }
        })
    }
    
}
