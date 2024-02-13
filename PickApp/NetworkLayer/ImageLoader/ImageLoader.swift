//
//  ImageLoader.swift
//  PickApp
//
//  Created by Roma on 7.02.24.
//

import UIKit
import PromiseKit
import Alamofire

protocol ImageLoader {
    func loadImages(page: Int, per_page: Int)
    func loadMorePhotos()
}

class ImageLoaderImp: ImageLoader {
    
    var apiKeys: APIKeys!
    
    private var photosResponse: [PhotoResponse] = []
    var currentPage = 1
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    static let shared = ImageLoaderImp()
    var runtimeStorage: RuntimeStorage!
    
    init() {
        guard let appID = ProcessInfo.processInfo.environment["APP_ID"],
              let accessKey = ProcessInfo.processInfo.environment["ACCESS_KEY"],
              let secretKey = ProcessInfo.processInfo.environment["SECRET_KEY"] else {
            fatalError("Couldn't get keys from environment variables")
        }
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
            self.runtimeStorage.addPhotos(photosResponse: photos, images: [])
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
