//
//  APIRouterStruct.swift
//  PickApp
//
//  Created by Roma on 4.02.24.
//

import Foundation
import Alamofire

struct APIRouterStruct: URLRequestConvertible {
    
    let apiRouter: APIRouter
    let apiKeys: APIKeys
    
    init(_ apiRouter: APIRouter, _ apiKeys: APIKeys) {
        self.apiRouter = apiRouter
        self.apiKeys = apiKeys
    }
    
    private func stringParameters(parameters: Parameters?) -> String {
        guard let parameters else { return "" }
        var stringParameters = "?"
        for (key, value) in parameters {
            let stringValue = value as? String ?? ""
            stringParameters += key + "=" + stringValue + "&"
        }
        return String(stringParameters.dropLast())
    }
    
    func asURLRequest() throws -> URLRequest {
        let stringParameters = stringParameters(parameters: apiRouter.parameters)
        let url = try (apiRouter.baseURL + apiRouter.path + stringParameters).asURL()
        var urlRequest = URLRequest(url: url)
        
        if let body = apiRouter.body {
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: body)
                urlRequest.httpBody = httpBody
                
            } catch {
                print("Fail to generate JSON data")
            }
        }
        
        let headers = APIHeaders(accessKey: apiKeys.accessKey)
        
        urlRequest.httpMethod = apiRouter.method.rawValue
        urlRequest.timeoutInterval = 20
        urlRequest.headers = headers.getHeaders()
        
        print("urlRequest: \(urlRequest)")
        return urlRequest
    }
}
