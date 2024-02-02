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
            
            let galeryCoordinator = self.coordinatorFactory.produceGaleryCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp.defaultFactory)
            
            galeryCoordinator.finishFlow = { [weak self, weak galeryCoordinator] in
                self?.removeDependency(galeryCoordinator)
            }
            
            self.addDependency(galeryCoordinator)
            galeryCoordinator.start()
        }
    }
    
    private func runFavoritesFlow() -> ((UINavigationController) -> Void) {
        
        return { navigationController in
            
            let favoritesCoordinator = self.coordinatorFactory.produceFavoritesCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp.defaultFactory)
            
            favoritesCoordinator.finishFlow = { [weak self, weak favoritesCoordinator] in
                self?.removeDependency(favoritesCoordinator)
            }
            favoritesCoordinator.start()
            self.addDependency(favoritesCoordinator)
        }
    }
}
