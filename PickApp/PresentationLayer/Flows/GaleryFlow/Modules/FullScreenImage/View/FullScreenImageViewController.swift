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
    
    var output: FullScreenImageViewOutput!
    var assembler: FullScreenImageAssemblyProtocol = FullScreenImageAssembly()
    var onBack: (() -> Void)?

    init(photo: Photo) {
        super.init(nibName: nil, bundle: nil)
        
        self.photo = photo
        self.imageView.image = photo.image
        self.descriptionLabel.text = photo.altDescription
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImage()
        setupBackButton()
        setupLikeButton()
        setupDescription()
        assembler.assemblyModuleForViewInput(viewInput: self)
    }
    
    func setupImage() {
        guard let photoWidth = photo.width, let photoHeight = photo.height else {
            return
        }
        let width = view.frame.width
        let height = width * CGFloat(photoHeight) / CGFloat(photoWidth)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupLikeButton() {
        let likeButton = UIButton(type: .system)
        likeButton.setTitle("Like", for: .normal)
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        view.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupDescription() {
        view.addSubview(descriptionLabel)
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc func backButtonPressed() {
        output.onBackPressed()
    }
    
    @objc func likeButtonPressed() {
        output.onLikePressed(with: photo.id)
    }
}


