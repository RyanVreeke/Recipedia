//
//  EndpointProtocol.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// Endpoint Protocol used to define what an Endpoint must implement.
protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    
    func urlRequest() throws -> URLRequest
}
