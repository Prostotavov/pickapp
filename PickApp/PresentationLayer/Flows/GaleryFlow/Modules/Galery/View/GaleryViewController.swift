// 
//  GaleryViewController.swift
//  PickApp
//
//  Created by MacBook Pro on 16.03.22.
//

import UIKit
import PromiseKit
import Alamofire

class GaleryViewController: UIViewController, GaleryViewInput, GaleryViewCoordinatorOutput {
    
    var output: GaleryViewOutput!
    var assembler: GaleryAssemblyProtocol = GaleryAssembly()
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    override func viewDidLoad() {
        
        let appID = "***"
        let accessKey = "***"
        let secretKey = "***"
        
        let apiKeys = APIKeys(appID: appID, accessKey: accessKey, secretKey: secretKey)
        getRandomPhoto(apiKeys)
        getPhotos(apiKeys)
        
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .purple
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getRandomPhoto(_ apiKeys: APIKeys) {
        let apiRouterStruct = APIRouterStruct(.randomPhoto, apiKeys)
        let photosPromise:  Promise<Photo> = session.request(apiRouterStruct)
        firstly {
            photosPromise
        }
        .then { photo -> Promise<Photo> in
            print(photo)
            return Promise<Photo>.value(photo)
        }
        .catch { error in
            print("error in ViewController: \(error)")
        }
        .finally {
            print("finally done")
        }
    }
    
    func getPhotos(_ apiKeys: APIKeys) {
        let apiRouterStruct = APIRouterStruct(.photos, apiKeys)
        let photosPromise:  Promise<[Photo]> = session.request(apiRouterStruct)
        firstly {
            photosPromise
        }
        .then { photos -> Promise<[Photo]> in
            print(photos)
            return Promise<[Photo]>.value(photos)
        }
        .catch { error in
            print("error in ViewController: \(error)")
        }
        .finally {
            print("finally done")
        }
    }
    
}
