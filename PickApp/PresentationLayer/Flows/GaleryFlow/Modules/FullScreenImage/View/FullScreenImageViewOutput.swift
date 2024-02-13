// 
//  FullScreenImageViewOutput.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation

protocol FullScreenImageViewOutput: AnyObject {
    
    func onLikePressed(for photo: Photo)
    func onBackPressed()
}
