//
//  GaleryViewCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol GaleryViewCoordinatorOutput: Presentable {
    var onImageCell: ((_ id: String) -> Void)? { get set }
}
