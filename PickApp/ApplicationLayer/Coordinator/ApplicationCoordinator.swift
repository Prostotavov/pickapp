//
//  ApplicationCoordinator.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation
import UIKit

final class ApplicationCoordinator: BaseCoordinator {

    private let flowFactory: FlowFactoryImp
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    init(router: Router,
         coordinatorFactory: CoordinatorFactory,
         flowFactory: FlowFactoryImp) {

        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.flowFactory = flowFactory
    }

    override func start() {
        runTabbarFlow()
    }
    
    private func runGaleryFlow() {

        let coordinator = coordinatorFactory.produceGaleryCoordinator(router: router, flowFactory: flowFactory)

        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }

        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTabbarFlow() {
        
         let (coordinator, module) = coordinatorFactory.produceTabbarCoordinator(coordinatorFactory: coordinatorFactory)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.runGaleryFlow()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }

}
