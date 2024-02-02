//
//  TabbarCoordinator.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorOutput {
    
    var finishFlow: (() -> Void)?
    
    private weak var tabbarOutput: (FlowTabbarCoordinatorOutput)?
    private let coordinatorFactory: CoordinatorFactory
    
    init(tabbarOutput: FlowTabbarCoordinatorOutput, coordinatorFactory: CoordinatorFactory) {
        
        self.tabbarOutput = tabbarOutput
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        
        tabbarOutput!.onGaleryFlow = runGaleryFlow()
        tabbarOutput!.onFavoritesFlow = runFavoritesFlow()
    }
    
    private func runGaleryFlow() -> ((UINavigationController) -> Void) {
        
        return { navigationController in
            
            let GaleryCoordinator = self.coordinatorFactory.produceGaleryCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp.defaultFactory)
            
            GaleryCoordinator.finishFlow = { [weak self, weak GaleryCoordinator] in
                self?.removeDependency(GaleryCoordinator)
            }
            
            self.addDependency(GaleryCoordinator)
            GaleryCoordinator.start()
        }
    }
    
    private func runFavoritesFlow() -> ((UINavigationController) -> Void) {
        
        return { navigationController in
            
            let FavoritesCoordinator = self.coordinatorFactory.produceFavoritesCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp.defaultFactory)
            
            FavoritesCoordinator.finishFlow = { [weak self, weak FavoritesCoordinator] in
                self?.removeDependency(FavoritesCoordinator)
            }
            FavoritesCoordinator.start()
            self.addDependency(FavoritesCoordinator)
        }
    }
}
