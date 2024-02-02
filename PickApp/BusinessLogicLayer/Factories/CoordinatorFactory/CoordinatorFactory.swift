//
//  CoordinatorFactory.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import  UIKit.UINavigationController

protocol CoordinatorFactory {

    func produceTabbarCoordinator(coordinatorFactory: CoordinatorFactory) -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?)
    
    // MARK: - Galery
    func produceGaleryCoordinator(flowFactory: GaleryFlowFactory) -> Coordinator & GaleryCoordinatorOutput
    func produceGaleryCoordinator(navigationController: UINavigationController?, flowFactory: GaleryFlowFactory) -> Coordinator & GaleryCoordinatorOutput
    func produceGaleryCoordinator(router: Router, flowFactory: GaleryFlowFactory) -> Coordinator & GaleryCoordinatorOutput
    
    // MARK: - Favorites
    func produceFavoritesCoordinator(flowFactory: FavoritesFlowFactory) -> Coordinator
    func produceFavoritesCoordinator(navigationController: UINavigationController?, flowFactory: FavoritesFlowFactory) -> Coordinator & FavoritesCoordinatorOutput
    func produceFavoritesCoordinator(router: Router, flowFactory: FavoritesFlowFactory) -> Coordinator & FavoritesCoordinatorOutput

}
