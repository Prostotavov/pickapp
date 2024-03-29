// 
//  FavoritesViewOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol FavoritesViewOutput: AnyObject {
    func loadView()
    func onImageCellTap(with content: Photo)
    func userDidScrollToEnd()
}
