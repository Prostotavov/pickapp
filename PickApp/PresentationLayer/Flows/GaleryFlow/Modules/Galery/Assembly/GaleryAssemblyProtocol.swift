// 
//  GaleryAssemblyProtocol.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

protocol GaleryAssemblyProtocol: AnyObject {
    
    func assemblyModuleForViewInput<UIViewController>(viewInput: UIViewController)
}
