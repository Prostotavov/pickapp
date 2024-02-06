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
    
    private var photosData: [PhotoResponse] = []
    private var collectionView: UICollectionView!
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()
    
    override func viewDidLoad() {
        
        collectionViewSetup()
        
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
        let photosPromise:  Promise<PhotoResponse> = session.request(apiRouterStruct)
        firstly {
            photosPromise
        }
        .done { photo in
            print(photo)
        }
        .catch { error in
            print("error in ViewController: \(error)")
        }
    }
    
    func getPhotos(_ apiKeys: APIKeys) {
        let apiRouterStruct = APIRouterStruct(.photos, apiKeys)
        let photosPromise:  Promise<[PhotoResponse]> = session.request(apiRouterStruct)
        firstly {
            photosPromise
        }
        .done { photos in
            self.photosData = photos
            self.collectionView.reloadData()
        }
        .catch { error in
            print("error in ViewController: \(error)")
        }
    }
    
}

extension GaleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCellIdentifier")
        collectionView.backgroundColor = UIColor.white
        
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCellIdentifier", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = photosData[indexPath.item]
        if let imageURL = URL(string: photo.urls!.small) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                        Storage.shared.addPhoto(photoResponse: photo, image: image)
                    }
                }
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = self.view.frame.width / 3 - 10
        return CGSize(width: cellSize , height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tappedID = photosData[indexPath.item].id else {
            return
        }
        output.onImageCellTap(with: tappedID)
    }
}
