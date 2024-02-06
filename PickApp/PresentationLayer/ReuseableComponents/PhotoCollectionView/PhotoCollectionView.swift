//
//  PhotoCollectionView.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import UIKit

protocol PhotoCollectionViewDelegate: AnyObject {
    func onImageCellTap(with id: String)
}

class PhotoCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView?
    var photos: [Photo] = []
    weak var delegate: PhotoCollectionViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewSetup()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cellSize = 110
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {return}
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = photos[indexPath.item].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.onImageCellTap(with: photos[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = self.frame.width / 3 - 10
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func reloadData(with photos: [Photo]) {
        self.photos = photos
        collectionView?.reloadData()
    }
}

