//
//  UIKitMapViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import Foundation
import MapKit

class UIKitMapViewModel: ObservableObject, MapViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var pointOfInterestCategories: [MKPointOfInterestCategory] = [.museum, .castle]
    @Published var search: String = ""
    @Published var searchResults: [MKMapItem] = []
    
    private let searchService = SearchService.shared
    
    // MARK: - Methods
    
    @MainActor
    func findPlace(for searchText: String) async throws {
        self.searchResults = try await searchService.searchPlace(for: searchText)
    }
    
}
