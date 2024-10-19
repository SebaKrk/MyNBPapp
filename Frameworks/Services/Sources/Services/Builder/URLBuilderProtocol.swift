//
//  URLBuilderProtocol.swift
//  Services
//
//  Created by Sebastian Sciuba on 19/10/2024.
//

import Foundation

/// URLBuilderProtocol
/// A protocol defining a method for constructing URLs with a specified path and query items.
/// - Provides a method to create a `URL` using a path and query parameters.
///
/// ### Example Usage:
/// ```swift
/// let builder: URLBuilderProtocol = URLBuilder()
/// let queryItems = [
///     URLQueryItem(name: "symbol", value: "USD"),
///     URLQueryItem(name: "startDate", value: "2024-01-01"),
///     URLQueryItem(name: "endDate", value: "2024-12-31")
/// ]
/// let url = builder.build(path: "/api/exchangerates/tables/A", queryItems: queryItems)
/// // Result: "https://api.nbp.pl/api/exchangerates/tables/A?symbol=USD&startDate=2024-01-01&endDate=2024-12-31"
/// ```
protocol URLBuilderProtocol {
    
    /// Builds a complete URL using the specified path and query items.
    /// - Parameters:
    ///   - path: A `String` representing the path for the API endpoint.
    ///   - queryItems: An array of `URLQueryItem` representing the query parameters to include in the URL.
    /// - Returns: An optional `URL` object constructed from the provided path and query items. Returns `nil` if the URL is invalid.
    func build(path: String, queryItems: [URLQueryItem]) -> URL?
}

/// URLBuilder
/// A utility struct for constructing URLs with a specified path and query items for NBP API requests.
/// - Implements `URLBuilderProtocol` to ensure consistency in method signatures.
/// - Uses predefined `https` scheme and `api.nbp.pl` host to build URLs for the NBP API.
///
/// ### Example Usage:
/// ```swift
/// let builder: URLBuilderProtocol = URLBuilder()
/// let queryItems = [
///     URLQueryItem(name: "symbol", value: "USD"),
///     URLQueryItem(name: "startDate", value: "2024-01-01"),
///     URLQueryItem(name: "endDate", value:
