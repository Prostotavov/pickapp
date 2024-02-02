// 
//  FavoritesViewController.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

class FavoritesViewController: UIViewController, FavoritesViewInput, FavoritesViewCoordinatorOutput {

    var output: FavoritesViewOutput!
    var assembler: FavoritesAssemblyProtocol = FavoritesAssembly()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .brown
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
