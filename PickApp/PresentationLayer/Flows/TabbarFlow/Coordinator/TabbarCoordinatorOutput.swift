//
//  TabbarCoordinatorOutput.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

protocol TabbarCoordinatorOutput: AnyObject {
    
    var finishFlow: (() -> Void)? { get set }
}
