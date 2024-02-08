// 
//  FavoritesViewCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol FavoritesViewCoordinatorOutput: Presentable {
    var onImageCell: ((_ id: String) -> Void)? { get set }
}
