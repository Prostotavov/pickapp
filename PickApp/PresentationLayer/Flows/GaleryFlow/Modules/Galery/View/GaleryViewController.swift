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
        galeryView.delegate = self
        view = galeryView
        ImageLoader().loadImages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .white
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GaleryViewController: GaleryViewDelegate {
    func onImageCellTap(with id: String) {
        output.onImageCellTap(with: id)
    }
    
    func reloadCollectionView(with photos: [Photo]) {
        galeryView.reloadData(with: photos)
    }
}
