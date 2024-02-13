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
    
    var onImageCell: ((Photo) -> Void)?
    
    override func loadView() {
        favoritesView.delegate = self
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .white
        output.loadView()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func reloadCollectionView(with photos: [Photo]) {
        favoritesView.reloadData(with: photos)
    }
}

extension FavoritesViewController: FavoritesViewDelegate {
    func onImageCellTap(with content: Photo) {
        output.onImageCellTap(with: content)
    }
    
    func userDidScrollToEnd() {
        output.userDidScrollToEnd()
    }
}
