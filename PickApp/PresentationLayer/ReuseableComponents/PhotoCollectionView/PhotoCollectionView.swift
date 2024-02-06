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
    var photosData: [PhotoResponse] = []
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
        let photo = photosData[indexPath.item]
        if let imageURL = URL(string: photo.urls!.small) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                        Storage.shared.addPhoto(photoResponse: photo, image: image)
                    }
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tappedID = photosData[indexPath.item].id else {
            return
        }
        delegate.onImageCellTap(with: tappedID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = self.frame.width / 3 - 10
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
}

