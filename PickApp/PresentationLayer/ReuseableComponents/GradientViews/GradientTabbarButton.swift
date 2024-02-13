//
//  GradientTabbarButton.swift
//  PickApp
//
//  Created by Roma on 9.02.24.
//

import UIKit

class GradientTabbarButton: UIButton {
    
    var colors: [UIColor] = [
        UIColor(hex: 0x58A7BF)!,
        UIColor(hex: 0x48D3FF)!
    ]
    
    var locations: [NSNumber] = [0.0, 1.0]
    
    var cornerMask: CACornerMask = []

    private let gradientLayer = CAGradientLayer()
    private var customImageView: UIImageView!
    private var isShadowsApplied = false
    private var shadows: [EdgeShadowLayer] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        gradientLayer.cornerRadius = 10
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradientLayer)
    }
    
    func setupColors(_ colors: [UIColor]) {
        gradientLayer.colors = colors.map{ $0.cgColor }
    }
    
    func setupLocations(_ locations: [NSNumber]) {
        gradientLayer.locations = locations
    }
    
    func setupCornerMask(_ mask: CACornerMask) {
        cornerMask = mask
        gradientLayer.maskedCorners = mask
    }
    
    func setupImage(_ image: UIImage?) {
        customImageView = UIImageView(image: image)
        customImageView.contentMode = .scaleAspectFit
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(customImageView)
        
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height / 10),
            customImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 3),
            customImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func setupTitle(_ text: String) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textAlignment = .center
        
        if let lobsterFont = UIFont(name: "Lobster-Regular", size: 16.0) {
            titleLabel.font = lobsterFont
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: self.frame.height / 3.3),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])

    }
    
    func resetShadows() {
        for shadow in shadows {
            shadow.removeFromSuperlayer()
        }
        isShadowsApplied = false
        self.layoutSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
        if isShadowsApplied { return }
        isShadowsApplied = true
        
        let topShadow =  EdgeShadowLayer(forView: self, edge: .Top, shadowRadius: 4, toColor: .white.withAlphaComponent(0), fromColor: .white.withAlphaComponent(0.7))

        let bottomShadow =  EdgeShadowLayer(forView: self, edge: .Bottom, shadowRadius: 4, toColor: .clear, fromColor: .black.withAlphaComponent(0.1))
        
        
        let leftShadow =  EdgeShadowLayer(forView: self, edge: .Left, shadowRadius: 4, toColor: .clear, fromColor: .black.withAlphaComponent(0.1))
        leftShadow.cornerRadius = 10
        leftShadow.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        let rightShadow =  EdgeShadowLayer(forView: self, edge: .Right, shadowRadius: 4, toColor: .clear, fromColor: .black.withAlphaComponent(0.1))
        rightShadow.cornerRadius = 10
        rightShadow.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        shadows = [topShadow, bottomShadow, leftShadow, rightShadow]
        for shadow in shadows {
            self.layer.addSublayer(shadow)
        }
    }
}
