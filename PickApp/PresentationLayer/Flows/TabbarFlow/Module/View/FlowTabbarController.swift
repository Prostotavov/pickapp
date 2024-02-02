//
//  FlowTabbarController.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

class FlowTabbarController: UITabBarController, UITabBarControllerDelegate, FlowTabbarCoordinatorOutput, FlowTabbarViewInput {
    
    var output: FlowTabbarViewOutput!
    var assembler: FlowTabbarAssemblyProtocol = FlowTabbarAssembly()
    
    var onGaleryFlow: ((UINavigationController) -> Void)?
    var onFavoritesFlow: ((UINavigationController) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        assembler.assemblyModuleForViewInput(viewInput: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nvc1 = UINavigationController()
        let nvc2 = UINavigationController()
        let controllers = [nvc1, nvc2]
        self.viewControllers = controllers
        startRootFlows()
    }
    
    func startRootFlows() {
        
        if let controller = viewControllers?[0] as? UINavigationController {
            onGaleryFlow?(controller)
        }
        
        if let controller = viewControllers?[1] as? UINavigationController {
            onFavoritesFlow?(controller)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setItemsImageInsets()
        setTabbarItems()
    }
    
    private func setTabbarItems() {
        
        tabBar.items![0].title = "Galery"
        tabBar.items![0].image = UIImage(systemName: "house.circle")
        tabBar.items![0].selectedImage = UIImage(systemName: "house.circle.fill")
        
        tabBar.items![1].title = "Favorites"
        tabBar.items![1].image = UIImage(systemName: "person.circle")
        tabBar.items![1].selectedImage = UIImage(systemName: "person.circle.fill")
        
    }
    
    private func setItemsImageInsets() {
        
        tabBar.items?.forEach({ (item) in
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        })
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
