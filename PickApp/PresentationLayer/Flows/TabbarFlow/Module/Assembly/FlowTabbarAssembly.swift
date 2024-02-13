//
//  FlowTabbarAssembly.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

class FlowTabbarAssembly: FlowTabbarAssemblyProtocol {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? FlowTabbarController {
            assembly(viewController: viewController)
        }
    }
    
    private func assembly(viewController: FlowTabbarController) {

        let presenter = FlowTabbarPresenter()
        
        presenter.view = viewController
        presenter.coordinator = viewController
        
        viewController.output = presenter
        
    }
    
}
