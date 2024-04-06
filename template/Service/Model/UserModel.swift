//
//  UserModel.swift
//  template
//
//  Created by Görkem Gür on 6.04.2024.
//

import Foundation

struct UserModel: Decodable {
    var userName: String?
    var userEmail: String?
    
}

struct UserRequest: URLRequestBuilder, Encodable {
    
    var httpMethod: HTTPMethod = .get
    var path: String = UserPaths.login.rawValue
}
