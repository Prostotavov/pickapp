//
//  GaleryViewCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

protocol GaleryViewCoordinatorOutput: UIViewController {
    var onImageCell: ((_ id: String) -> Void)? { get set }
}
