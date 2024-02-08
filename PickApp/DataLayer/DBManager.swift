//
//  DBManager.swift
//  PickApp
//
//  Created by Roma on 7.02.24.
//

import Foundation
import RealmSwift

class DBManager {
    
    static let shared = DBManager()
    
    private var realm: Realm {
        do {
            return try Realm()
            print("SUCCESS")
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func createPhotoCollection(name: CollecionNames, photos: List<DBPhoto> = List<DBPhoto>()) {
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
    
    func addPhoto(_ photo: DBPhoto, toCollectionWithName collectionName: CollecionNames) {
        do {
            try realm.write {
                let photoCollections = realm.objects(DBPhotoCollection.self).filter("name == %@", collectionName)
                if let photoCollection = photoCollections.first {
                    photoCollection.photos.append(photo)
                    print("[Photo added] \(getPhotoCollections())")
                } else {
                    print("Collection with name '\(collectionName.rawValue)' not found.")
                }
                
            }
        } catch {
            print("Error adding photo to collection: \(error)")
        }
    }
    
    func deletePhoto(withId photoId: String, fromCollectionWithName collectionName: CollecionNames) {
        do {
            try realm.write {
                let photoCollections = realm.objects(DBPhotoCollection.self).filter("name == %@", collectionName.rawValue)
                if let photoCollection = photoCollections.first {
                    if let photoToDelete = photoCollection.photos.first(where: { $0.id == photoId }) {
                        realm.delete(photoToDelete)
                        print("[Photo deleted] \(getPhotoCollections())")
                    }
                }
            }
        } catch {
            print("Error deleting photo from collection: \(error)")
        }
    }
    
}

