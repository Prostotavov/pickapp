// 
//  FullScreenImageViewController.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//


import UIKit

class FullScreenImageViewController: UIViewController, FullScreenImageViewInput, FullScreenImageViewCoordinatorOutput {
    
    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()
    private var photo: Photo!
    private var fullScreenImageView: FullScreenImageView!
    let side_offset: CGFloat = 0
    let top_offset: CGFloat = 0
    
    var output: FullScreenImageViewOutput!
    var assembler: FullScreenImageAssemblyProtocol = FullScreenImageAssembly()
    var onBack: (() -> Void)?

    init(photo: Photo) {
        print("[init]")
        super.init(nibName: nil, bundle: nil)
        self.photo = photo
        self.imageView.image = photo.image
        self.descriptionLabel.text = photo.altDescription
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        assembler.assemblyModuleForViewInput(viewInput: self)
        fullScreenImageView = FullScreenImageView(frame: self.view.frame, photo: photo)
        fullScreenImageView.delegate = self
        view.addSubview(fullScreenImageView)
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension FullScreenImageViewController: FullScreenImageViewDelegate {
    
    func onBackPressed() {
        output.onBackPressed()
    }
    
    func onLikePressed(for photo: Photo) {
        output.onLikePressed(for: photo)
    }
}
