//
//  FlowTabbarCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit.UINavigationController

protocol FlowTabbarCoordinatorOutput: AnyObject {
    
    var onGaleryFlow: ((UINavigationController) -> Void)? { get set }
    var onFavoritesFlow: ((UINavigationController) -> Void)? { get set }
}
