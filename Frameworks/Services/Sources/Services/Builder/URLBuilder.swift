//
//  URLBuilder.swift
//  Services
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

import Foundation

import Foundation

/// URLBuilder
/// A utility struct for constructing URLs with a specified path and query items for NBP API requests.
/// - Uses predefined `https` scheme and `api.nbp.pl` host.
/// - Simplifies the creation of URLs by encapsulating the logic of constructing `URLComponents`.
///
/// ### Example Usage:
/// ```swift
/// let builder = URLBuilder()
/// let queryItems = [
///     URLQueryItem(name: "symbol", value: "USD"),
///     URLQueryItem(name: "startDate", value: "2024-01-01"),
///     URLQueryItem(name: "endDate", value: "2024-12-31")
/// ]
/// let url = builder.build(path: "/api/exchangerates/tables/A", queryItems: queryItems)
/// // Result: "https://api.nbp.pl/api/exchangerates/tables/A?symbol=USD&startDate=2024-01-01&endDate=2024-12-31"
/// ```
public struct URLBuilder: URLBuilderProtocol {
    
    // MARK: - Properties
    /// The URL scheme to be used for constructing the URL.
    /// - Default value is `https`.
    private let scheme: String = "https"
    
    /// The host for NBP API requests.
    /// - Default value is `api.nbp.pl`.
    private let host: String = "api.nbp.pl"
    
    // MARK: - Methods
    /// Builds a complete URL using the specified path and query items.
    /// - Parameters:
    ///   - path: A `String` representing the path for the API endpoint.
    ///   - queryItems: An array of `URLQueryItem` representing the query parameters to include in the URL.
    /// - Returns: An optional `URL` object constructed from the provided path and query items. Returns `nil` if the URL is invalid.
    ///
    /// ### Example Usage:
    /// ```swift
    /// let queryItems = [
    ///     URLQueryItem(name: "symbol", value: "USD"),
    ///     URLQueryItem(name: "startDate", value: "2024-01-01"),
    ///     URLQueryItem(name: "endDate", value: "2024-12-31")
    /// ]
    /// let url = URLBuilder().build(path: "/api/exchangerates/tables/A", queryItems: queryItems)
    /// // Result: "https://api.nbp.pl/api/exchangerates/tables/A?symbol=USD&startDate=2024-01-01&endDate=2024-12-31"
    /// ```
    public func build(path: String, queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}
