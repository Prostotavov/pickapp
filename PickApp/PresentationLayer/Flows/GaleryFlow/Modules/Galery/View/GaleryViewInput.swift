// 
//  GaleryViewInput.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

protocol GaleryViewInput: AnyObject {
    func reloadCollectionView(with photos: [Photo])
    func updateImage(at indexPath: IndexPath, with image: UIImage?)
}
