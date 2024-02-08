//
//  ImageLoader.swift
//  PickApp
//
//  Created by Roma on 7.02.24.
//

import UIKit
import PromiseKit
import Alamofire

class ImageLoader {
    
    let appID = "562730"
    let accessKey = "TrARTBODRW3UIkwQt8OuyeujG21qDrH3IUbUfAYWt2k"
    let secretKey = "DwXJppWhVtElskHv4NzHUGr5rtBEcW6nNrKbKfV-VvA"
    
    var apiKeys: APIKeys!
    
    private var photosResponse: [PhotoResponse] = []
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    init() {
        self.apiKeys = APIKeys(appID: appID, accessKey: accessKey, secretKey: secretKey)
    }
    
    func loadImages() {
        let apiRouterStruct = APIRouterStruct(.photos, apiKeys)
        let photosPromise:  Promise<[PhotoResponse]> = session.request(apiRouterStruct)
        firstly {
            photosPromise
        }
        .done { photos in
            TempImageStorage.shared.addPhotos(photosResponse: photos, images: [])
            self.photosResponse = photos
            self.getAndStoreImages()
        }
        .catch { error in
            print("error in getPhotos: \(error)")
        }
    }
    
    private func getAndStoreImages() {
        for photo in photosResponse {
            guard let imageURL = URL(string: photo.urls!.small) else {
                return
            }
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else {
                    return
                }
                TempImageStorage.shared.addPhoto(photoResponse: photo, image: UIImage(data: imageData))
            }
        }
    }
    
}
