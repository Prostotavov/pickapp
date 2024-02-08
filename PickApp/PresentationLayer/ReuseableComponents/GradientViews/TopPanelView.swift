//
//  TopPanelView.swift
//  PickApp
//
//  Created by Roma on 8.02.24.
//

import UIKit

class TopPanelView: UIView {

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#58A7BF")!.cgColor,
            UIColor(hex: "#34FFF3")!.cgColor,
            UIColor(hex: "#48D3FF")!.cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
        
        
        let topShadow = EdgeShadowLayer(forView: self, edge: .Bottom, shadowRadius: 7, toColor: .clear, fromColor: .black.withAlphaComponent(0.25))
        self.layer.addSublayer(topShadow)
    }
}

