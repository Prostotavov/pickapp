// 
//  GaleryInteractorInput.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

protocol GaleryInteractorInput: AnyObject {

    func loadImage(from url: URL?, completionHandler: @escaping (Data?) -> Void)
}
