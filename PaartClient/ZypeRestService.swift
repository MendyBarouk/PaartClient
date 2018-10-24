//
//  ZypeRestService.swift
//  PaartClient
//
//  Created by Menahem Barouk on 24/10/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation
import Alamofire

extension ZypeApi.Link {
    var urlRequest: URLRequest
    {
        var linkURLComponents        = URLComponents()
        linkURLComponents.scheme     = "https"
        linkURLComponents.host       = host
        linkURLComponents.path       = path
        linkURLComponents.queryItems = query
        
        let url = linkURLComponents.url!
        
        let urlRequest = try! URLRequest(url: url, method: methode, headers: header)
        
        let encodedUrlRequest = try! encoding.encode(urlRequest, with: parameters)
        
        return encodedUrlRequest
    }
}

enum ZypeApi {
    
    enum Link {
        case register(email: String, password: String)
    }
}


private extension ZypeApi.Link {
    static let KOAuth_GetTokenDomain = "login.zype.com"
    static let apiDomain = "api.zype.com"
    static let appKey = "app_key"
    static let kAppKey = "iWKxMIlomxpVy62sn-0lmR9z_zP7mmLBRfPbFQXWSJvSljyJMc-jC6fdflR7c2tI"
    
    var host: String {
        let host: String
        
        switch self {
        case .register: host = ZypeApi.Link.apiDomain
        }
        
        return host
    }
    
    var path: String {
        let path: String
        
        switch self {
        case .register: path = "/consumers"
        }
        
        return path
    }
    
    var query: [URLQueryItem]? {
        let query: [URLQueryItem]?
        
        switch self {
        case .register:
            query = [
                URLQueryItem(name: ZypeApi.Link.appKey, value: ZypeApi.Link.kAppKey)
            ]
        }
        
        return query
    }
    
    var parameters: Parameters? {
        let parameters: Parameters?
        
        switch self {
        case let .register(email, password):
            parameters = [
                "consumer": [
                    "email":email,
                    "password":password
                ]
            ]
        }
        
        return parameters
    }
    
    var methode: HTTPMethod {
        let methode: HTTPMethod
        
        switch self {
        case .register: methode = .post
        }
        
        return methode
    }
    
    var header: HTTPHeaders? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

class ZypeRestService {
    static let shared = ZypeRestService()
    
    func register(withUsername email: String, password: String, completion: @escaping (_ response: DataResponse<Any>)->()) {
        SessionManager.default.request(ZypeApi.Link.register(email: email, password: password).urlRequest).responseJSON { (dataResponse) in
            
            print(dataResponse)
            completion(dataResponse)
        }
    }
    
    func getToken(withUsername username: String, password: String, completion: ()->()) {
        
    }
}
