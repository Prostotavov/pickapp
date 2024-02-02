//
//  FlowNavigationController.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

class FlowNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        let popViewController = super.popViewController(animated: animated)
        return popViewController
    }
}
