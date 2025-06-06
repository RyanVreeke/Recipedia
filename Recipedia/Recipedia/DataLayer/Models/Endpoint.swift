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
        headers: [String : String]? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
    }
    
    /// Creates a URLRequest to be used in network calls.
    /// - Returns: A URL request with the given Endpoint information.
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

extension Endpoint {
    static func buildGetEndpointMock() -> Endpoint {
        return Endpoint(
            baseURL: "https://d3jbb8n5wk0qxi.cloudfront.net",
            path: "/recipes.com",
            httpMethod: .get,
            headers: ["Accept": "application/json"]
        )
    }
    
    static func buildInvalidURLGetEndpointMock() -> Endpoint {
        return Endpoint(
            baseURL: "",
            path: "",
            httpMethod: .get,
            headers: ["Accept": "application/json"]
        )
    }
}
