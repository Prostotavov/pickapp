//
//  CoordinatorFactoryImpl.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit.UINavigationController

class CoordinatorFactoryImp: CoordinatorFactory {
    
    static let defaultFactory = CoordinatorFactoryImp()
    
    private func router(_ controller: UINavigationController?) -> Router {
        
        let router = RouterImp(rootController: navigationController(controller))
        return router
    }
    
    private func navigationController(_ controller: UINavigationController?) -> UINavigationController {
        
        if let navigationController = controller {
            return navigationController
        } else {
            return FlowNavigationController()
        }
    }
    
    func produceTabbarCoordinator(coordinatorFactory: CoordinatorFactory) -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?) {
        
        let controller = FlowTabbarController()
        let coordinator = TabbarCoordinator(tabbarOutput: controller, coordinatorFactory: coordinatorFactory)
        return (coordinator, controller)
    }
}

// MARK: - Galery
extension CoordinatorFactoryImp {
    func produceGaleryCoordinator(flowFactory: GaleryFlowFactory) -> Coordinator & GaleryCoordinatorOutput {
        
        let coordinator = produceGaleryCoordinator(navigationController: nil, flowFactory: flowFactory)
        return coordinator
    }
    
    func produceGaleryCoordinator(navigationController: UINavigationController?, flowFactory: GaleryFlowFactory) -> Coordinator & GaleryCoordinatorOutput {
        
        let coordinator = produceGaleryCoordinator(router: router(navigationController), flowFactory: flowFactory)
        return coordinator
    }
    
    func produceGaleryCoordinator(router: Router, flowFactory: GaleryFlowFactory) -> Coordinator & GaleryCoordinatorOutput {
        
        let coordinator = GaleryCoordinator(router: router, factory: flowFactory)
        return coordinator
    }
}

// MARK: - Favorites
extension CoordinatorFactoryImp {
    func produceFavoritesCoordinator(flowFactory: FavoritesFlowFactory) -> Coordinator {
        
        let coordinator = produceFavoritesCoordinator(navigationController: nil, flowFactory: flowFactory)
        return coordinator
    }
    
    func produceFavoritesCoordinator(navigationController: UINavigationController?, flowFactory: FavoritesFlowFactory) -> Coordinator & FavoritesCoordinatorOutput {
        
        let coordinator = produceFavoritesCoordinator(router: router(navigationController), flowFactory: flowFactory)
        return coordinator
    }
    
    func produceFavoritesCoordinator(router: Router, flowFactory: FavoritesFlowFactory) -> Coordinator & FavoritesCoordinatorOutput {
        
        let coordinator = FavoritesCoordinator(router: router, factory: flowFactory)
        return coordinator
    }
}
