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
    var favoritesView = FavoritesView()
    
    override func loadView() {
        favoritesView.delegate = self
        view = favoritesView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .brown
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension FavoritesViewController: FavoritesViewDelegate {
    func onImageCellTap(with id: String) {
        
    }
}
