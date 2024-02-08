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
    
    let topPanelOffset: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        assembler.assemblyModuleForViewInput(viewInput: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        let nvc1 = UINavigationController()
        let nvc2 = UINavigationController()

        let controllers = [nvc1, nvc2]
        self.viewControllers = controllers
        
        
        startRootFlows()
        setupTopPanel()
        setupCV(withIndex: 0)
    }
    
    private func setupCV(withIndex index: Int) {
        for i in (0..<self.viewControllers!.count) {
            self.viewControllers![i].view.translatesAutoresizingMaskIntoConstraints = false
            if i != index { continue }
            NSLayoutConstraint.activate([
                self.viewControllers![i].view!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topPanelOffset + 5),
                self.viewControllers![i].view!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                self.viewControllers![i].view!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.viewControllers![i].view!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
        }
    }
    
    private func startRootFlows() {
        
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
    
    private func setupTopPanel() {
        let gradientView = TopPanelView(frame: .zero)
        self.view.addSubview(gradientView)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topPanelOffset),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func setTabbarItems() {
        
        tabBar.items![0].title = "Galery"
        tabBar.items![0].image = UIImage(systemName: "house.circle")
        tabBar.items![0].selectedImage = UIImage(systemName: "house.circle.fill")
        
        tabBar.items![1].title = "Favorites"
        tabBar.items![1].image = UIImage(systemName: "person.circle")
        tabBar.items![1].selectedImage = UIImage(systemName: "person.circle.fill")
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setupCV(withIndex: tabBarController.selectedIndex)
        
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
