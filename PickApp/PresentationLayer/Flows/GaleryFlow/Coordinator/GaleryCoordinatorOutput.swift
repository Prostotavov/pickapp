//
//  GaleryCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol GaleryCoordinatorOutput: AnyObject {
    
    var finishFlow: (() -> Void)? { get set }
}
