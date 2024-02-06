// 
//  FullScreenImageViewOutput.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation

protocol FullScreenImageViewOutput: AnyObject {
    
    func onLikePressed(with id: String)
    func onBackPressed()
}
