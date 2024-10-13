//
//  URLBuilder.swift
//  Services
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

import Foundation

public struct URLBuilder {
    
    private let scheme: String = "https"
    private let host: String = "api.nbp.pl"
    
    public func build(path: String, queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
}

