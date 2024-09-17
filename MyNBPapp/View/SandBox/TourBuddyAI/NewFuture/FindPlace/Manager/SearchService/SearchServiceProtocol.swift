//
//  SearchServiceProtocol.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/09/2024.
//

import Foundation
import MapKit

/// SearchServiceProtocol
/// Protocol that defines the contract for any search service implementation.
/// > Important:
///  **Program to an Interface, Not an Implementation** 
/// This follows the programing principle.
/// It allows for flexibility in choosing or changing the actual service implementation without modifying dependent code.
protocol SearchServiceProtocol {
    
    /// Performs a search for places based on the provided search text.
    /// - Parameter searchText: A `String` containing the search query for the place.
    /// - Returns: An array of `MKMapItem` objects that match the search query.
    /// - Throws: `SearchError` if the query is empty, no results are found, or if the request fails.
    func searchPlace(for searchText: String) async throws -> [MKMapItem]
}
