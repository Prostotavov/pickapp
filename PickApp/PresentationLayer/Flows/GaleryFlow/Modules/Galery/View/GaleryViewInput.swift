// 
//  GaleryViewInput.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

protocol GaleryViewInput: AnyObject {
    func reloadCollectionView(with photos: [Photo])
}
