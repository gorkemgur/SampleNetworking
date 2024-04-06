import Foundation

protocol URLRequestBuilder {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    func makeURLRequest<T: Codable>(with requestBody: T?) -> URLRequest?
}

extension URLRequestBuilder {
    var baseURL: String { "google.com" }
    var headers: [String: String] { [:] }
    var path: String { "" }
    
    func makeURLRequest<T: Codable>(with requestBody: T?) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            print("Error creating URL components")
            return nil
        }
        urlComponents.path = path
        urlComponents.scheme = "https"
        
        guard let url = urlComponents.url else {
            print("Error creating URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        if let requestBody = requestBody {
            do {
                request.httpBody = try JSONEncoder().encode(requestBody)
            } catch {
                print("Error encoding HTTP body: \(error)")
                return nil
            }
        }
        
        return request
    }
    
    func buildURLRequest() -> URLRequest {
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

enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
