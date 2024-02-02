//
//  FlowFactoryImp.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

import UIKit.UIViewController

class FlowFactoryImp {
    
    static let defaultFactory = FlowFactoryImp()
}

extension FlowFactoryImp: GaleryFlowFactory {
    
    func produceGaleryOutput() -> GaleryViewCoordinatorOutput {
        return GaleryViewController()
    }
}

extension FlowFactoryImp: FavoritesFlowFactory {
    
    func produceFavoritesOutput() -> FavoritesViewCoordinatorOutput {
        return FavoritesViewController()
    }
}
