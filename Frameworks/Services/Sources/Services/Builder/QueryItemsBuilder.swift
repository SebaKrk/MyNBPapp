//
//  QueryItemsBuilder.swift
//  Services
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

import Foundation

// Parametry zapytania
public class QueryItemsBuilder {
    
    private var queryItems = [URLQueryItem]()
    
    func addQueryItem(name: String, value: String) -> Self {
        queryItems.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    public func build() -> [URLQueryItem] {
        return queryItems
    }
}
