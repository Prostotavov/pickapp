// 
//  FavoritesAssembly.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

class FavoritesAssembly: FavoritesAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? FavoritesViewController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: FavoritesViewController) {
        
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let databaseManager = DatabaseManagerImp()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor
        presenter.databaseManager = databaseManager

        interactor.output = presenter
        
        viewController.output = presenter
        databaseManager.output = presenter
        
    }
    
}
