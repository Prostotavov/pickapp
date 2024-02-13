// 
//  GaleryViewOutput.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import UIKit

protocol GaleryViewOutput: AnyObject {
    
    func loadImage(at indexPath: IndexPath, from url: URL)
    func onImageCellTap(with content: Photo)
    func userDidScrollToEnd()
    func loadView()
}
