//
//  PhotoCollectionView.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import UIKit

protocol PhotoCollectionViewDelegate: AnyObject {
    func onImageCellTap(with content: Photo)
    func userDidScrollToEnd()
    func loadImage(at indexPath: IndexPath, from url: URL)
}

class PhotoCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView?
    var photos: [Photo] = []
    weak var delegate: PhotoCollectionViewDelegate!
    
    let cellOffset: CGFloat = 5
    var hasReachedEnd = false
    
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
        guard let imageURL = URL(string: photos[indexPath.row].url) else {
            return cell
        }
        delegate?.loadImage(at: indexPath, from: imageURL)
        cell.imageView.image = photos[indexPath.item].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else {
            return
        }
        var photo = photos[indexPath.item]
        photo.image = cell.imageView.image
        delegate.onImageCellTap(with: photo)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (self.frame.width - cellOffset * 2) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellOffset
    }
    
    func reloadData(with photos: [Photo]) {
        self.photos = photos
        collectionView?.reloadData()
    }
    
    func updateImage(at indexPath: IndexPath, with image: UIImage?) {
        guard let cell = collectionView?.cellForItem(at: indexPath) as? PhotoCollectionViewCell else {
            return
        }
        cell.imageView.image = image
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        let endThreshold: CGFloat = 100

        if offsetY > contentHeight - screenHeight - endThreshold {
            if !hasReachedEnd {
                userDidScrollToEnd()
                hasReachedEnd = true
            }
        } else {
            hasReachedEnd = false
        }
        
    }

    func userDidScrollToEnd() {
        delegate.userDidScrollToEnd()
    }
}

