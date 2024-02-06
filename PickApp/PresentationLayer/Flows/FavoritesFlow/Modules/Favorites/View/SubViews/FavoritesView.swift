//
//  FavoritesView.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func onImageCellTap(with id: String)
}

class FavoritesView: UIView {
    
    let photoCollectionView = PhotoCollectionView()
    
    weak var delegate: FavoritesViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        photoCollectionView.delegate = self
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCollectionView() {
        self.addSubview(photoCollectionView)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    func reloadData(with photos: [Photo]) {
        photoCollectionView.reloadData(with: photos)
    }
}

extension FavoritesView: PhotoCollectionViewDelegate {
    func onImageCellTap(with id: String) {
        delegate.onImageCellTap(with: id)
    }
}
