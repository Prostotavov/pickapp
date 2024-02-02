//
//  Coordinator.swift
//  PickApp
//
//  Created by Roma on 2.02.24.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func start(with option: DeepLinkOption?)
}
