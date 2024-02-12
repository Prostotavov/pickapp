//
//  Router.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

protocol Router {
    
    func present(_ module: UIViewController?)
    func present(_ module: UIViewController?, animated: Bool)
    
    func push(_ module: UIViewController?)
    func push(_ module: UIViewController?, animated: Bool)
    func push(_ module: UIViewController?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: UIViewController?)
    func setRootModule(_ module: UIViewController?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}
