//
//  PathBuilder.swift
//  Services
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

import Foundation


//
//  PathBuilder.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

/// PathBuilder
/// A utility class for building dynamic URL paths for NBP API requests.
/// - Implements `PathBuilderProtocol` to ensure consistency in method signatures.
/// - Uses a **Builder pattern** to construct complex URLs step by step.
/// - Allows setting different path segments like resource paths, currency symbols, and date ranges.
///
/// ### Example Usage:
/// ```swift
/// let builder = PathBuilder()
/// let url = builder.setPath(.cenyzlota)
///                  .append("last")
///                  .append("5")
///                  .build()
/// // Result: "/api/cenyzlota/last/5"
/// ```
public class PathBuilder: PathBuilderProtocol {
    
    // MARK: - Properties
    /// An array that stores the segments of the URL.
    /// This array is used to build the final URL path by joining all its components.
    private var components = [String]()
    
    // MARK: - Methods
    /// Sets the base path for the API request.
    /// - Parameter basePath: A `NBPResourcePath` enum value that represents the base API path (e.g., `.exchangeRates` or `.cenyzlota`).
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// let builder = PathBuilder()
    /// builder.setPath(.exchangeRates)
    /// ```
    public func setPath(_ basePath: NBPResourcePath) -> Self {
        components.append(basePath.rawValue)
        return self
    }
    
    /// Appends an additional segment to the URL path.
    /// - Parameter segment: A `String` representing a segment to add to the path.
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// builder.append("last")
    /// ```
    public func append(_ segment: String) -> Self {
        components.append(segment)
        return self
    }
    
    /// Sets the rates segment of the URL path.
    /// - Parameter rates: A `String` specifying the rates, such as "tables".
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// builder.setRates("tables")
    /// ```
    public func setRates(_ rates: String) -> Self {
        components.append(rates)
        return self
    }
    
    /// Sets the table type for currency rates.
    /// - Parameter table: A `String` that represents the type of table (`"A"`, `"B"`, or `"C"`).
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// builder.setTable("A")
    /// ```
    public func setTable(_ table: String) -> Self {
        components.append(table)
        return self
    }
    
    /// Sets the currency symbol for the URL path.
    /// - Parameter symbol: A `String` containing the three-letter currency code (ISO 4217 standard), such as "EUR".
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// builder.setSymbol("USD")
    /// ```
    public func setSymbol(_ symbol: String) -> Self {
        components.append(symbol)
        return self
    }
    
    /// Sets the start date for the query in the URL path.
    /// - Parameter startDate: A `String` representing the start date in `YYYY-MM-DD` format.
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// builder.setStartDate("2024-01-01")
    /// ```
    public func setStartDate(_ startDate: String) -> Self {
        components.append(startDate)
        return self
    }
    
    /// Sets the end date for the query in the URL path.
    /// - Parameter endDate: A `String` representing the end date in `YYYY-MM-DD` format.
    /// - Returns: `Self` to allow for method chaining.
    ///
    /// ### Example Usage:
    /// ```swift
    /// builder.setEndDate("2024-12-31")
    /// ```
    public func setEndDate(_ endDate: String) -> Self {
        components.append(endDate)
        return self
    }
    
    /// Builds the final URL path by joining all added components.
    /// - Returns: A `String` containing the complete URL path.
    ///
    /// ### Example Usage:
    /// ```swift
    /// let url = builder.setPath(.exchangeRates)
    ///                  .setTable("A")
    ///                  .setSymbol("EUR")
    ///                  .setStartDate("2024-01-01")
    ///                  .setEndDate("2024-12-31")
    ///                  .build()
    /// // Result: "/api/exchangerates/tables/A/EUR/2024-01-01/2024-12-31"
    /// ```
    public func build() -> String {
        return components.joined(separator: "/")
    }
}
