//
//  NBPResourcePath.swift
//  Services
//
//  Created by Sebastian Sciuba on 19/10/2024.
//

import Foundation

/// NBPResourcePath
/// An enumeration representing the base paths available for NBP API requests.
/// - `cenyzlota`: Represents the endpoint for gold prices.
/// - `exchangeRates`: Represents the endpoint for exchange rates.
///
/// ### Example Usage:
/// ```swift
/// let path = NBPResourcePath.cenyzlota.rawValue
/// // Result: "/api/cenyzlota"
/// ```
///
/// Use this enumeration to set the base path when building URLs with `PathBuilder`.
public enum NBPResourcePath: String {
    case cenyzlota = "/api/cenyzlota"
    case exchangeRates = "/api/exchangerates"
}
