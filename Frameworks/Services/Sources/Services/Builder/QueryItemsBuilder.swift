//
//  QueryItemsBuilder.swift
//  Services
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

import Foundation

import Foundation

/// QueryItemsBuilder
/// A utility class for building an array of `URLQueryItem` objects for use in URL requests.
/// - Uses a **Builder pattern** to construct query items step by step, allowing for a clean and easy-to-read code when creating query parameters.
///
/// ### Example Usage:
/// ```swift
/// let builder = QueryItemsBuilder()
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
public class QueryItemsBuilder: QueryItemsBuilderProtocol {
    
    // MARK: - Properties
    /// An array that stores the query items to be built.
    /// This array is used to store each `URLQueryItem` as they are added.
    private var queryItems = [URLQueryItem]()
    
    // MARK: - Methods
    /// Adds a new query item to the list.
    /// - Parameters:
    ///   - name: A `String` representing the name of the query item.
    ///   - value: A `String` representing the value associated with the query item.
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// builder.addQueryItem(name: "symbol", value: "USD")
    /// ```
    func addQueryItem(name: String, value: String) -> Self {
        queryItems.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    /// Builds and returns the array of `URLQueryItem` objects.
    /// - Returns: An array of `URLQueryItem` containing all added query items.
    ///
    /// ### Example Usage:
    /// ```swift
    /// let queryItems = builder.build()
    /// // Result: [URLQueryItem(name: "symbol", value: "USD")]
    /// ```
    public func build() -> [URLQueryItem] {
        return queryItems
    }
}


