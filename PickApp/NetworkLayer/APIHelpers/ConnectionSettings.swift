//
//  ConnectionSettings.swift
//  PickApp
//
//  Created by Roma on 3.02.24.
//

import Foundation
import Alamofire

struct ConnectionSettings { }

extension ConnectionSettings {
    static func sessionManager() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        let sessionManager = Session(configuration: configuration, startRequestsImmediately: false)
        return sessionManager
    }
}
