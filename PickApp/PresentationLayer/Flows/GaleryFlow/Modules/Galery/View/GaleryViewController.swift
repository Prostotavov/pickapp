// 
//  GaleryViewController.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit

class GaleryViewController: UIViewController, GaleryViewInput, GaleryViewCoordinatorOutput {
    
    var output: GaleryViewOutput!
    var assembler: GaleryAssemblyProtocol = GaleryAssembly()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .purple
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
