//
//  FavoritesCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol FavoritesCoordinatorOutput: AnyObject {
    
    var finishFlow: (() -> Void)? { get set }
}
