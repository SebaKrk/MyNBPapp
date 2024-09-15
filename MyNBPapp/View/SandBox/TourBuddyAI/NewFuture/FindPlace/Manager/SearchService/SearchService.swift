//
//  SearchService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/09/2024.
//

import MapKit

// MARK: - SearchService (Singleton & Facade)
/// A service responsible for performing place searches using `MKLocalSearch`.
/// - Uses the **Singleton pattern** to ensure there is only one shared instance of this service.
/// - Acts as a **Facade** by hiding the complexity of creating the `MKLocalSearch.Request` and performing the search.
final class SearchService: SearchServiceProtocol {
    
    /// Singleton instance
    /// > Important: This is a **Singleton** instance, which ensures that the entire app shares a single instance
    /// of `SearchService`, preventing unnecessary multiple instances and ensuring resource efficiency.
    static let shared = SearchService()
    
    /// Private initializer to enforce Singleton
    /// The private initializer prevents the creation of additional instances outside of this class,
    /// which is a key feature of the **Singleton pattern**.
    private init() {}
    
    // MARK: - searchPlace Method
    /// > Important: This method acts as a **Facade** for the internal `performSearch` method, simplifying the external API.
    /// Performs a place search based on the provided search text.
    /// - Parameter searchText: A string that represents the natural language query for the place search.
    /// - Returns: An array of `MKMapItem` objects matching the search query.
    /// - Throws: `SearchError`
    func searchPlace(for searchText: String) async throws -> [MKMapItem] {
        return try await performSearch(with: searchText)
    }
    
    // MARK: - performSearch Method
    /// > Important: This method follows the **Single Responsibility Principle (SRP)** by handling only the logic for performing the search.
    /// This method performs the actual place search using `MKLocalSearch`.
    /// - Parameter searchText: A string containing the place name or query.
    /// - Returns: An array of `MKMapItem` objects that represent the search results.
    /// - Throws: `SearchError`
    
    private func performSearch(with searchText: String) async throws -> [MKMapItem] {
        guard !searchText.isEmpty else { throw  SearchError.emptyQuery }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        
        do {
            let response = try await search.start()
            guard !response.mapItems.isEmpty else { throw SearchError.noResults }
            
            return response.mapItems
            
        } catch {
            throw SearchError.requestFailed(error)
        }
    }
    
}
