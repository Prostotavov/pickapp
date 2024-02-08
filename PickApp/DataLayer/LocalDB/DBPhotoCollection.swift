//
//  DBPhotoCollection.swift
//  PickApp
//
//  Created by Roma on 7.02.24.
//

import Foundation
import RealmSwift

class DBPhotoCollection: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var photos: List<DBPhoto>
}
