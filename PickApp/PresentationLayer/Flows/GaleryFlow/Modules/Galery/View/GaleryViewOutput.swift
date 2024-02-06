// 
//  GaleryViewOutput.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation
import UIKit

protocol GaleryViewOutput: AnyObject {
    
    func onImageCellTap(with id: String)
}
