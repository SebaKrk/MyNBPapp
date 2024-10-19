//
//  QueryItemsBuilderProtocol.swift
//  Services
//
//  Created by Sebastian Sciuba on 19/10/2024.
//

import Foundation

/// QueryItemsBuilderProtocol
/// A protocol defining methods for building an array of `URLQueryItem` objects.
/// - Provides a method for adding query items and a method for building the final array.
///
/// ### Example Usage:
/// ```swift
/// let builder: QueryItemsBuilderProtocol = QueryItemsBuilder()
/// let queryItems = builder.addQueryItem(name: "symbol", value: "USD")
///                         .addQueryItem(name: "startDate", value: "2024-01-01")
///                         .addQueryItem(name: "endDate", value: "2024-12-31")
///                         .build()
/// // Result: [
/// //   URLQueryItem(name: "symbol", value: "USD"),
/// //   URLQueryItem(name: "startDate", value: "2024-01-01"),
/// //   URLQueryItem(name: "endDate", value: "2024-12-31")
/// // ]
/// ```
protocol QueryItemsBuilderProtocol {
    
    /// Adds a new query item to the list.
    /// - Parameters:
    ///   - name: A `String` representing the name of the query item.
    ///   - value: A `String` representing the value associated with the query item.
    /// - Returns: `Self` to allow for method chaining.
    func addQueryItem(name: String, value: String) -> Self
    
    /// Builds and returns the array of `URLQueryItem` objects.
    /// - Returns: An array of `URLQueryItem` containing all added query items.
    func build() -> [URLQueryItem]
}
