//
//  FlowTabbar.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import UIKit

class FlowTabbar: UITabBar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        isTranslucent = false
        shadowImage = UIImage()
    }
}
