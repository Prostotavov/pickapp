//
//  TempImageStorage.swift
//  PickApp
//
//  Created by Roma on 6.02.24.
//

import Foundation
import UIKit

protocol StorageOutput: AnyObject {
    func newPhotosAdded(_ photos: [Photo])
}

struct TempImageStorage {
    
    static var shared = TempImageStorage()
    
    private var photos: [Photo]
    
    weak var output: StorageOutput!
    
    init() {
        photos = []
    }
    
    mutating func addPhotos(photosResponse: [PhotoResponse], images: [UIImage?]) {
        for i in 0...photosResponse.count {
            if photosResponse.indices.contains(i) && images.indices.contains(i) {
                if photos.contains(where: {$0.id == photosResponse[i].id}) {
                    for (index, photo) in photos.enumerated() {
                        if photo.id == photosResponse[i].id {
                            photos[index].image = images[i]
                        }
                    }
                    continue
                }
                photos.append(Photo(photoResponse: photosResponse[i], image: images[i]))
                continue
            }
            if photosResponse.indices.contains(i) {
                photos.append(Photo(photoResponse: photosResponse[i], image: nil))
                continue
            }
        }
        output.newPhotosAdded(photos)
    }
    
    mutating func addPhoto(photoResponse: PhotoResponse, image: UIImage?) {
        if photos.contains(where: {$0.id == photoResponse.id}) {
            for (index, photo) in photos.enumerated() {
                if photo.id == photoResponse.id {
                    photos[index].image = image
                }
            }
            output.newPhotosAdded(photos)
            return
        }
        photos.append(Photo(photoResponse: photoResponse, image: image))
        output .newPhotosAdded(photos)
    }
    
    func getPhoto(with id: String) -> Photo? {
        return photos.first { $0.id == id }
    }
    
}
