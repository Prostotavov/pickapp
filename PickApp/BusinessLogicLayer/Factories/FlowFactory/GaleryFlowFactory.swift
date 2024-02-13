//
//  GaleryFlowFactory.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol GaleryFlowFactory {
    
    func produceGaleryOutput() -> GaleryViewCoordinatorOutput
    func produceFullScreenImageOutput(with content: Photo) -> FullScreenImageViewCoordinatorOutput?
}
