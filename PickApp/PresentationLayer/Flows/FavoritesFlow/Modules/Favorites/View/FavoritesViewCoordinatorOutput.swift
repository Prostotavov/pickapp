// 
//  FavoritesViewCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

protocol FavoritesViewCoordinatorOutput: UIViewController {
    var onImageCell: ((_ content: Photo) -> Void)? { get set }
}
