// 
//  FullScreenImageViewCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import UIKit

protocol FullScreenImageViewCoordinatorOutput: UIViewController {
    var onBack: (() -> Void)? { get set }
}
