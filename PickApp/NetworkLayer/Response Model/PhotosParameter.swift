//
//  PhotosParameter.swift
//  PickApp
//
//  Created by Roma on 9.02.24.
//

import Foundation

struct PhotosParameter {
    let page: Int?
    let per_page: Int?
}

extension PhotosParameter {
    func parametersForAPIRequest() -> [String: String] {
        var body: [String: String] = [:]
        if let page {
            body["page"] = "\(page)"
        }
        if let per_page {
            body["per_page"] = "\(per_page)"
        }
        return body
    }
}
