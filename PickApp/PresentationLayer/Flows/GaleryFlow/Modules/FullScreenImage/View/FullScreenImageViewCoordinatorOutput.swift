// 
//  FullScreenImageViewCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation

protocol FullScreenImageViewCoordinatorOutput: Presentable {
    var onBack: (() -> Void)? { get set }
}
