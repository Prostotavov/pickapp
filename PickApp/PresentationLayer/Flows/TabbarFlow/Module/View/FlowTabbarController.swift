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
    let side_offset: CGFloat = 5
    
    private var bottomTB: BottomTabbarView!
    
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
        let nvc3 = UINavigationController()

        let controllers = [nvc1, nvc2, nvc3]
        self.viewControllers = controllers
        
        setTabbar()
        startRootFlows()
        setupTopPanel()
        setupCV(withIndex: 0)
    }
    
    private func setupCV(withIndex index: Int) {
        for i in (0..<self.viewControllers!.count) {
            self.viewControllers![i].view.translatesAutoresizingMaskIntoConstraints = false
            if i != index { continue }
            NSLayoutConstraint.activate([
                self.viewControllers![i].view!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topPanelOffset + side_offset),
                self.viewControllers![i].view!.bottomAnchor.constraint(equalTo: bottomTB.topAnchor),
                self.viewControllers![i].view!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.viewControllers![i].view!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
        }
    }
    
    private func startRootFlows() {
        
        if let controller = viewControllers?[0] as? UINavigationController {
            onGaleryFlow?(controller)
        }
        
        if let controller = viewControllers?[2] as? UINavigationController {
            onFavoritesFlow?(controller)
        }
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
    
    private func setTabbar() {
        self.tabBar.isHidden = true
        
        let height = tabBar.frame.height + 20
        let width = tabBar.frame.width
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        bottomTB = BottomTabbarView(frame: frame)
        bottomTB.delegate = self
        view.addSubview(bottomTB)
        bottomTB.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomTB.heightAnchor.constraint(equalToConstant: height),
            bottomTB.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomTB.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomTB.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    func createImageWithBackgroundColor(color: UIColor, size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setupCV(withIndex: tabBarController.selectedIndex)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

extension FlowTabbarController: BottobTabbarViewDelegate {
    
    func buttonPressed(withIndex index: Int) {
        guard index >= 0 && index < viewControllers?.count ?? 0 else {
            return
        }
        if tabBarController(self, shouldSelect: viewControllers?[index] ?? UIViewController()) {
            selectedIndex = index
            tabBarController(self, didSelect: viewControllers?[index] ?? UIViewController())
        }
    }
    
}
