//
//  APIRouter.swift
//  PickApp
//
//  Created by Roma on 3.02.24.
//

import Foundation
import Alamofire

protocol APIRouterProtocol {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
    var body: Parameters? { get }
}

enum APIRouter: APIRouterProtocol {
    
    case photos(_ params: PhotosParameter)
    case randomPhoto
    case loadImage(_ url: String)
    
    var baseURL: String {
        switch self {
        case let .loadImage(url):
            return url
        default:
            return "https://api.unsplash.com"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        case .randomPhoto:
            return "/photos/random"
        default:
            return ""
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .photos(params):
            return params.parametersForAPIRequest()
        default:
            return nil
        }
    }
    
    var body: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var idNeedAuth: Bool {
        switch self {
        case .loadImage:
            return false
        default:
            return true
        }
    }
    
}
