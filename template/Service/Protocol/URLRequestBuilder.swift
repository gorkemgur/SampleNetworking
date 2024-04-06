import Foundation

protocol URLRequestBuilder {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {
    var baseURL: String { "google.com" }
    var headers: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    var path: String { "" }
    
    var urlRequest: URLRequest {
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            fatalError("Invalid URL")
        }
        
        // Ensure HTTPS scheme
        urlComponents.scheme = "https"
        
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
}

enum HTTPMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
