//
//  ServiceManager.swift
//  template
//
//  Created by Görkem Gür on 6.04.2024.
//

import Foundation

protocol ApiProtocol {
    var session: URLSession { get }
    func fetch<T: Decodable, T1: Encodable>(type: T.Type, with request: URLRequest, body: T1?) async throws -> T
}

extension ApiProtocol {
    
    func fetch<T: Decodable, T1: Encodable>(type: T.Type, with request: URLRequest, body: T1?) async throws -> T {
        
        var newUrlRequest: URLRequest = request
        
        if let body = body {
            do {
                newUrlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                print("Error encoding HTTP body: \(error)")
                throw ApiError.responseUnsuccessful(description: "Status code: Body Convert Error")
            }
        }
        
        let (data, response) = try await session.data(for: newUrlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Invalid response")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
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



