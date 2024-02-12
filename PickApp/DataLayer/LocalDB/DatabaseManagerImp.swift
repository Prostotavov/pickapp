//
//  DatabaseManagerImp.swift
//  PickApp
//
//  Created by Roma on 7.02.24.
//

import Foundation
import RealmSwift

protocol DatabaseManagerOutput: AnyObject {
    func newPhotosLiked()
}

protocol DatabaseManager {
    func createPhotoCollection(name: DBCollecionNames, photos: List<DBPhoto>)
    func savePhotoCollection(_ photoCollection: DBPhotoCollection)
    func deletePhotoCollection(_ photoCollection: DBPhotoCollection)
    func getPhotoCollections() -> Results<DBPhotoCollection>
    func addPhoto(_ photo: DBPhoto, toCollectionWithName collectionName: DBCollecionNames)
    func deletePhoto(withId photoId: String, fromCollectionWithName collectionName: DBCollecionNames)
    func getPhotos(fromCollectionWithName collectionName: DBCollecionNames) -> [Photo]
    func isExistPhoto(withId photoId: String, inCollectionWithName collectionName: DBCollecionNames) -> Bool
    func isExist(collectionWithName collectionName: DBCollecionNames) -> Bool
    func deleteAllData()
}

class DatabaseManagerImp: DatabaseManager {
    
    weak var output: DatabaseManagerOutput!
    
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func createPhotoCollection(name: DBCollecionNames, photos: List<DBPhoto> = List<DBPhoto>()) {
        guard !isExist(collectionWithName: name) else {
            return
        }
        do {
            try realm.write {
                let collection = DBPhotoCollection()
                collection.name = name.rawValue
                collection.photos = photos
                realm.add(collection)
            }
        } catch {
            print("Error saving photo collection to Realm: \(error)")
        }
    }
    
    func savePhotoCollection(_ photoCollection: DBPhotoCollection) {
        do {
            try realm.write {
                realm.add(photoCollection)
            }
        } catch {
            print("Error saving photo collection to Realm: \(error)")
        }
    }

    func deletePhotoCollection(_ photoCollection: DBPhotoCollection) {
        do {
            try realm.write {
                realm.delete(photoCollection)
            }
        } catch {
            print("Error deleting photo collection from Realm: \(error)")
        }
    }
    
    func getPhotoCollections() -> Results<DBPhotoCollection> {
        return realm.objects(DBPhotoCollection.self)
    }
    
    func addPhoto(_ photo: DBPhoto, toCollectionWithName collectionName: DBCollecionNames) {
        do {
            try realm.write {
                let photoCollections = realm.objects(DBPhotoCollection.self).filter("name == %@", collectionName.rawValue)
                if let photoCollection = photoCollections.first {
                    photoCollection.photos.append(photo)
                    guard output != nil else {
                        return
                    }
                    output.newPhotosLiked()
                } else {
                    print("Collection with name '\(collectionName)' not found.")
                }
                
            }
        } catch {
            print("Error adding photo to collection: \(error)")
        }
    }
    
    func deletePhoto(withId photoId: String, fromCollectionWithName collectionName: DBCollecionNames) {
        do {
            try realm.write {
                let photoCollections = realm.objects(DBPhotoCollection.self).filter("name == %@", collectionName.rawValue)
                if let photoCollection = photoCollections.first {
                    if let photoToDelete = photoCollection.photos.first(where: { $0.id == photoId }) {
                        realm.delete(photoToDelete)
                        guard output != nil else {
                            return
                        }
                        output.newPhotosLiked()
                    }
                }
            }
        } catch {
            print("Error deleting photo from collection: \(error)")
        }
    }
    
    func getPhotos(fromCollectionWithName collectionName: DBCollecionNames) -> [Photo] {
        var photos: [Photo] = []
        do {
            try realm.write {
                guard let favCollection = realm.objects(DBPhotoCollection.self).filter("name == %@", collectionName.rawValue).first else {
                    return []
                }
                
                for dbPhoto in favCollection.photos {
                    photos.append(Photo(dbPhoto: dbPhoto))
                }
                return photos
            }
        } catch {
            print("Error deleting photo from collection: \(error)")
        }
        return photos
    }
    
    func isExistPhoto(withId photoId: String, inCollectionWithName collectionName: DBCollecionNames) -> Bool {
        var isExist: Bool = false
        do {
            try realm.write {
                let photoCollections = realm.objects(DBPhotoCollection.self).filter("name == %@", collectionName.rawValue)
                if let photoCollection = photoCollections.first {
                    if photoCollection.photos.contains(where: { $0.id == photoId }) {
                        isExist = true
                    }
                }
                return isExist
            }
        } catch {
            print("Error deleting photo from collection: \(error)")
        }
        return isExist
    }
    
    func isExist(collectionWithName collectionName: DBCollecionNames) -> Bool {
        var isExist: Bool = false
        do {
            try realm.write {
                let photoCollections = realm.objects(DBPhotoCollection.self).filter("name == %@", collectionName.rawValue)
                if let _ = photoCollections.first {
                    isExist = true
                }
                return isExist
            }
        } catch {
            print("Error deleting photo from collection: \(error)")
        }
        return isExist
    }
    
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error deleting all data in Realm: \(error)")
        }
    }
    
}

