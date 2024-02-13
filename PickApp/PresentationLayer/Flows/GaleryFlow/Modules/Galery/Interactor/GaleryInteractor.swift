// 
//  GaleryInteractor.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import Foundation

class GaleryInteractor: GaleryInteractorInput {
    
    weak var output: GaleryInteractorOutput!
    
    func loadImage(from url: URL?, completionHandler: @escaping (Data?) -> Void) {
        guard let imageURL = url else {
            completionHandler(nil)
            return
        }

        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL) {
                completionHandler(imageData)
            } else {
                completionHandler(nil)
            }
        }
    }
}
