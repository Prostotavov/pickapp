//
//  FullScreenImageView.swift
//  PickApp
//
//  Created by Roma on 13.02.24.
//

import UIKit

protocol FullScreenImageViewDelegate: AnyObject {
    func onBackPressed()
    func onLikePressed(for photo: Photo)
}

class FullScreenImageView: UIView {
    
    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()
    private var photo: Photo!
    
    var onBack: (() -> Void)?
    
    weak var delegate: FullScreenImageViewDelegate!
    
    init(frame: CGRect, photo: Photo) {
        super.init(frame: frame)
        self.photo = photo
        self.isUserInteractionEnabled = true
        setupImage()
        setupBackButton()
        setupLikeButton()
        setupDescription()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupImage() {
        guard let photoWidth = photo.width, let photoHeight = photo.height else {
            return
        }
        self.imageView.image = photo.image
        let width = self.frame.width
        let height = width * CGFloat(photoHeight) / CGFloat(photoWidth)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    func setupLikeButton() {
        let likeButton = UIButton(type: .system)
        likeButton.setTitle("Like", for: .normal)
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        self.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    func setupDescription() {
        self.descriptionLabel.text = photo.altDescription
        self.addSubview(descriptionLabel)
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)
        ])
    }
    
    @objc func backButtonPressed() {
        delegate.onBackPressed()
    }
    
    @objc func likeButtonPressed() {
        delegate.onLikePressed(for: photo)
    }
}
