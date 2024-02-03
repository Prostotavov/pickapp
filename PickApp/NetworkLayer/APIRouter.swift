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
    
    case photos
    case randomPhoto
    
    var baseURL: String {
        switch self {
        default:
            return "https://api.unsplash.com"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .photos:
            return .get
        case .randomPhoto:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        case .randomPhoto:
            return "/photos/random"
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
    
}
