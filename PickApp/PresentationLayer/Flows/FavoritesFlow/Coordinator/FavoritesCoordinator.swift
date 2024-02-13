//
//  FavoritesCoordinator.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

class FavoritesCoordinator: BaseCoordinator, FavoritesCoordinatorOutput {
    
    var finishFlow: (() -> Void)?
    
    private let factory: FavoritesFlowFactory
    private let router: Router
    
    init(router: Router, factory: FavoritesFlowFactory) {
        
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showFavorites()
    }

    private func showFavorites() {
        let favoritesOutput = factory.produceFavoritesOutput()
        
        favoritesOutput.onImageCell = { [weak self] (content) in
            self?.showFullScreenImage(with: content)
        }
        
        router.setRootModule(favoritesOutput, hideBar: true)
    }
    
    private func showFullScreenImage(with content: Photo) {
        let fullScreenImageOutput = factory.produceFullScreenImageOutput(with: content)
        
        fullScreenImageOutput?.onBack = { [weak self] in
            self?.router.dismissModule(animated: true, completion: nil)
        }
        
        router.present(fullScreenImageOutput, animated: true)
    }
    
}
