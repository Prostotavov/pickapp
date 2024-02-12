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
    var currentPage = 1
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    static let shared = ImageLoader()
    
    init() {
        self.apiKeys = APIKeys(appID: appID, accessKey: accessKey, secretKey: secretKey)
    }
    
    func loadImages(page: Int = 1, per_page: Int = 28) {
        let params = PhotosParameter(page: page, per_page: per_page)
        let apiRouterStruct = APIRouterStruct(.photos(params), apiKeys)
        let photosPromise:  Promise<[PhotoResponse]> = session.request(apiRouterStruct)
        firstly {
            photosPromise
        }
        .done { photos in
            TempImageStorage.shared.addPhotos(photosResponse: photos, images: [])
            self.photosResponse = photos
        }
        .catch { error in
            print("error in getPhotos: \(error)")
        }
    }
    
    func loadMorePhotos() {
        currentPage += 1
        loadImages(page: currentPage)
    }
    
}
