//
//  GaleryView.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import UIKit

protocol GaleryViewDelegate: AnyObject {
    func onImageCellTap(with id: String)
    func userDidScrollToEnd()
}

class GaleryView: UIView {
    
    let photoCollectionView = PhotoCollectionView()
    let side_offset: CGFloat = 5
    
    weak var delegate: GaleryViewDelegate!
    
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
            photoCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -side_offset),
            photoCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: side_offset),
        ])
    }
    
    func reloadData(with photos: [Photo]) {
        photoCollectionView.reloadData(with: photos)
    }
}

extension GaleryView: PhotoCollectionViewDelegate {
    func onImageCellTap(with id: String) {
        delegate.onImageCellTap(with: id)
    }
    
    func userDidScrollToEnd() {
        delegate.userDidScrollToEnd()
    }
}
