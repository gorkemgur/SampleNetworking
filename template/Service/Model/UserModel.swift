//
//  UserModel.swift
//  template
//
//  Created by Görkem Gür on 6.04.2024.
//

import Foundation

struct UserModel: URLRequestBuilder, Codable {
    var httpMethod: HTTPMethod = .get
    var path: String = UserPaths.login.rawValue
    
    var userName: String?
    var userEmail: String?
    
    var req: URLRequest {
        return buildURLRequest()
    }
    
}
