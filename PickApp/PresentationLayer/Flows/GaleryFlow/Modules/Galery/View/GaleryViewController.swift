// 
//  GaleryViewController.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit
import PromiseKit
import Alamofire

class GaleryViewController: UIViewController, GaleryViewInput, GaleryViewCoordinatorOutput {
        
    var output: GaleryViewOutput!
    var assembler: GaleryAssemblyProtocol = GaleryAssembly()
    var onImageCell: ((String) -> Void)?
    
    var galeryView = GaleryView()

    override func loadView() {
        assembler.assemblyModuleForViewInput(viewInput: self)
        galeryView.delegate = self
        view = galeryView
        output.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func updateImage(at indexPath: IndexPath, with image: UIImage?) {
        galeryView.updateImage(at: indexPath, with: image)
    }
    
    func reloadCollectionView(with photos: [Photo]) {
        galeryView.reloadData(with: photos)
    }
}

extension GaleryViewController: GaleryViewDelegate {
    
    func loadImage(at indexPath: IndexPath, from url: URL) {
        output.loadImage(at: indexPath, from: url)
    }
    
    func onImageCellTap(with id: String) {
        output.onImageCellTap(with: id)
    }
    
    func userDidScrollToEnd() {
        output.userDidScrollToEnd()
    }
}
