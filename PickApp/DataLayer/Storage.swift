//
//  Storage.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation
import UIKit

struct Storage {
    
    static var shared = Storage()
    
    private var photos: [Photo]
    
    init() {
        photos = []
    }
    
    mutating func addPhoto(photoResponse: PhotoResponse, image: UIImage?) {
        self.photos.append(Photo(photoResponse: photoResponse, image: image))
    }
    
    func getPhoto(with id: String) -> Photo? {
        return photos.first { $0.id == id }
    }
}
