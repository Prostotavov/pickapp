// 
//  FavoritesViewInput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol FavoritesViewInput: AnyObject {
    func reloadCollectionView(with photos: [Photo])
}
