//
//  UIColor+Hex.swift
//  PickApp
//
//  Created by Roma on 8.02.24.
//

import UIKit

extension UIColor {
    convenience init?(hex: Int) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
