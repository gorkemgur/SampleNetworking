//
//  ServiceManager.swift
//  template
//
//  Created by Görkem Gür on 6.04.2024.
//

import Foundation

protocol ApiProtocol {
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension ApiProtocol {
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Invalid response")
        }
        guard httpResponse.statusCode == 200 else {
            throw ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}

final class ServiceManager: ApiProtocol {
    let session: URLSession
    
    static let sharedInstance = ServiceManager(configuration: .default)
    
    private init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
}



