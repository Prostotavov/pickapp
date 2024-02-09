//
//  GaleryCoordinator.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

class GaleryCoordinator: BaseCoordinator, GaleryCoordinatorOutput {
    
    // MARK: - AuthorizationCoordinatorOutput
    
    var finishFlow: (() -> Void)?
    
    private let factory: GaleryFlowFactory
    private let router: Router
    
    init(router: Router, factory: GaleryFlowFactory) {
        
        self.factory = factory
        self.router = router
    }
    
    // MARK: - BaseCoordinator
    
    override func start() {
        showGalery()
    }
    
    // MARK: - Flow's controllers

    private func showGalery() {
        let galeryOutput = factory.produceGaleryOutput()
        
        galeryOutput.onImageCell = { [weak self] (id) in
            self?.showFullScreenImage(with: id)
        }
        
        router.setRootModule(galeryOutput, hideBar: true)
    }
    
    private func showFullScreenImage(with id: String) {
        let fullScreenImageOutput = factory.produceFullScreenImageOutput(with: id)
        
        fullScreenImageOutput?.onBack = { [weak self] in
            self?.router.dismissModule(animated: true, completion: nil)
        }
        
        router.present(fullScreenImageOutput, animated: true)
    }

}
