//
//  NetworkRoutes.swift
//  template
//
//  Created by Görkem Gür on 7.04.2024.
//

import Foundation

class NetworkRoutes {
    static func registerUser() async throws -> UserModel {
        do {
            let response: UserModel = try await ServiceManager.sharedInstance.fetch(type: UserModel.self, with: UserRequest().urlRequest, body: EmptyRequest())
            return response
        } catch {
            throw error
        }
    }
}

struct EmptyRequest: Encodable {
    
}
