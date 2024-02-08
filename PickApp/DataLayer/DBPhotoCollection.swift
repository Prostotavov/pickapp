//
//  DBPhotoCollection.swift
//  PickApp
//
//  Created by Roma on 7.02.24.
//

import Foundation
import RealmSwift

enum CollecionNames: String {
    case favorites
}

class DBPhotoCollection: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String
    @Persisted var photos: List<DBPhoto>
}
