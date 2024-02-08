//
//  DBPhoto.swift
//  PickApp
//
//  Created by Roma on 8.02.24.
//

import Foundation
import RealmSwift

class DBPhoto: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var url: String
    @Persisted var imageData: Data
    @Persisted var imagedescription: String
    @Persisted var altDescription: String
    @Persisted var width: Int
    @Persisted var height: Int
}
