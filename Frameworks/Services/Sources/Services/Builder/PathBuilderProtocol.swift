//
//  PathBuilderProtocol.swift
//  Services
//
//  Created by Sebastian Sciuba on 19/10/2024.
//

import Foundation

/// PathBuilderProtocol
/// A protocol defining methods for building dynamic URL paths for NBP API requests.
/// - Provides methods for setting different path segments like resource paths, currency symbols, and date ranges.
///
/// ### Example Usage:
/// ```swift
/// let builder: PathBuilderProtocol = PathBuilder()
/// let url = builder.setPath(.exchangeRates)
///                  .setTable("A")
///                  .setSymbol("USD")
///                  .setStartDate("2024-01-01")
///                  .setEndDate("2024-12-31")
///                  .build()
/// // Result: "/api/exchangerates/tables/A/USD/2024-01-01/2024-12-31"
/// ```
protocol PathBuilderProtocol {
    
    func setPath(_ basePath: NBPResourcePath) -> Self
    func append(_ segment: String) -> Self
    func setRates(_ rates: String) -> Self
    func setTable(_ table: String) -> Self
    func setSymbol(_ symbol: String) -> Self
    func setStartDate(_ startDate: String) -> Self
    func setEndDate(_ endDate: String) -> Self
    func build() -> String
}
