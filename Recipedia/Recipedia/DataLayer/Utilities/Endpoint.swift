//
//  Endpoint.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// Endpoint class that can be used in services to make network requests.
class Endpoint: EndpointProtocol {
    let baseURL: String
    let path: String
    let httpMethod: HTTPMethod
    let headers: [String : String]?
    
    /// Initializes an Endpoint class.
    /// - Parameters:
    ///   - baseURL: The baseURL for the endpoint.
    ///   - path: The specified path for the endpoint.
    ///   - httpMethod: The HTTP method for the endpoint.
    ///   - headers: The headers to be added to the endpoint.
    init(
        baseURL: String,
        path: String,
        httpMethod: HTTPMethod,
        headers: [String : String]?
    ) {
        self.baseURL = baseURL
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
    }
    
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        
        return request
    }
}
