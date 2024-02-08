// 
//  GaleryAssembly.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class GaleryAssembly: NSObject, GaleryAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? GaleryViewController {
            assembly(with: viewController)
        }
    }
    
    private func assembly(with viewController: GaleryViewController) {
        
        let presenter = GaleryPresenter()
        let interactor = GaleryInteractor()
            
        presenter.view = viewController
        presenter.coordinator = viewController
        presenter.interactor = interactor
        
        interactor.output = presenter
        viewController.output = presenter
        TempImageStorage.shared.output = presenter
    }
    
}
