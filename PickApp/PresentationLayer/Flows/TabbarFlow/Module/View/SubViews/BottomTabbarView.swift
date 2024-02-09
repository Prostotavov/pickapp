//
//  BottomTabbarView.swift
//  PickApp
//
//  Created by Roma on 9.02.24.
//

import UIKit

protocol BottobTabbarViewDelegate: AnyObject {
    func buttonPressed(withIndex index: Int)
}

class BottomTabbarView: UIView, UITabBarDelegate {
    
    weak var delegate: BottobTabbarViewDelegate!
    
    var heightConstraints: [NSLayoutConstraint] = []
    
    private var buttons: [GradientTabbarButton] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupButtons() {
        
        let width = self.frame.width / 3
        let height = self.frame.height
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        
        let button0 = GradientTabbarButton(frame: frame)
        button0.setupColors([UIColor(hex: "#56A9C0")!, UIColor(hex: "#3FE3E2")!])
        button0.setupCornerMask([.layerMaxXMinYCorner])
        button0.setupImage(UIImage(named: "galery"))
        button0.setupTitle("Galery")
        button0.tag = 0
        
        let button1 = GradientTabbarButton(frame: frame)
        button1.setupColors([UIColor(hex: "#3FE3E2")!, UIColor(hex: "#3BF0F7")!])
        button1.setupCornerMask([.layerMaxXMinYCorner, .layerMinXMinYCorner])
        button1.setupImage(UIImage(named: "new_post"))
        button1.setupTitle("New Post")
        button1.tag = 1
        
        let button2 = GradientTabbarButton(frame: frame)
        button2.setupColors([UIColor(hex: "#3BF0F7")!, UIColor(hex: "#15A6F8")!])
        button2.setupCornerMask([.layerMinXMinYCorner])
        button2.setupImage(UIImage(named: "favorites"))
        button2.setupTitle("Favorites")
        button2.tag = 2
        
        buttons = [button0, button1, button2]
        
        
        
        for (index, button) in buttons.enumerated() {
            self.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            let topConstraint = button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
            heightConstraints.append(topConstraint)
            NSLayoutConstraint.activate([
                topConstraint,
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                button.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat((index + 1)) * width),
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(index) * width),
            ])
            
            
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    }
    
    @objc func buttonPressed(_ sender: GradientTabbarButton) {
        delegate.buttonPressed(withIndex: sender.tag)
        for (index, constraint) in heightConstraints.enumerated() {
            UIView.animate(withDuration: 0.5) {
                if index == sender.tag {
                    constraint.constant = 0
                } else {
                    constraint.constant = 10
                }
                sender.resetShadows()
                self.layoutIfNeeded()
            }
        }
        for button in buttons {
            button.resetShadows()
        }
    }
}

