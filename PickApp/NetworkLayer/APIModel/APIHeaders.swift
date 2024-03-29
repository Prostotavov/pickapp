//
//  APIHeaders.swift
//  PickApp
//
//  Created by Roma on 3.02.24.
//

import Alamofire

struct APIHeaders {
    var contentType: String = "application/json"
    var accessKey: String
    
    func getHeaders(isNeedAuth: Bool) -> HTTPHeaders {
        var headersDictionary: [String: String] = [:]
        headersDictionary["Content-Type"] = contentType
        if isNeedAuth {
            headersDictionary["Authorization"] = "Client-ID \(accessKey)"
        }
        return HTTPHeaders(headersDictionary)
    }
}
