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
    var onImageCell: ((String) -> Void)?
    
    var galeryView = GaleryView()
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    
    override func loadView() {
        galeryView.delegate = self
        view = galeryView
    }
    
    override func viewDidLoad() {
        let appID = "562730"
        let accessKey = "TrARTBODRW3UIkwQt8OuyeujG21qDrH3IUbUfAYWt2k"
        let secretKey = "DwXJppWhVtElskHv4NzHUGr5rtBEcW6nNrKbKfV-VvA"
        
        let apiKeys = APIKeys(appID: appID, accessKey: accessKey, secretKey: secretKey)
        getPhotos(apiKeys)
        
        super.viewDidLoad()
        assembler.assemblyModuleForViewInput(viewInput: self)
        view.backgroundColor = .purple
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getPhotos(_ apiKeys: APIKeys) {
        let apiRouterStruct = APIRouterStruct(.photos, apiKeys)
        let photosPromise:  Promise<[PhotoResponse]> = session.request(apiRouterStruct)
        firstly {
            photosPromise
        }
        .done { photos in
            self.galeryView.reloadData(with: photos)
        }
        .catch { error in
            print("error in getPhotos: \(error)")
        }
    }
    
}

extension GaleryViewController: GaleryViewDelegate {
    func onImageCellTap(with id: String) {
        output.onImageCellTap(with: id)
    }
}
