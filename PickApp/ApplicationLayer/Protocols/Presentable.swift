//
//  Presentable.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit.UIViewController

protocol Presentable: AnyObject {

    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

    func toPresent() -> UIViewController? {
        return self
    }
}
