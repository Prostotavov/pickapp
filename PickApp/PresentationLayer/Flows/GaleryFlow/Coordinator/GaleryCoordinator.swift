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
        let GaleryOutput = factory.produceGaleryOutput()
        
        router.setRootModule(GaleryOutput, hideBar: true)
    }

}
