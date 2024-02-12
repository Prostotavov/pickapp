// 
//  FullScreenImageAssembly.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import UIKit

class FullScreenImageAssembly: FullScreenImageAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? FullScreenImageViewController {
            assembly(with: viewController)
        }
    }
    
    func assembly(with viewController: FullScreenImageViewController) {
        
        let presenter = FullScreenImagePresenter()
        let interactor = FullScreenImageInteractor()
        let databaseManager = DatabaseManagerImp()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        interactor.databaseManager = databaseManager
        
        viewController.output = presenter
        
    }
    
}
