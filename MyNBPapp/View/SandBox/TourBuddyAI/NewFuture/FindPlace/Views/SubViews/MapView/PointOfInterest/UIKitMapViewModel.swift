//
//  UIKitMapViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import Foundation
import MapKit

class UIKitMapViewModel: ObservableObject, MapViewModelProtocol {
    
    @Published var pointOfInterestCategories: [MKPointOfInterestCategory] = [.museum, .castle]
    @Published var search: String = ""
    @Published var searchResults: [MKMapItem] = []
    
    @MainActor
    func findPlace(for searchText: String) async {
        guard !searchText.isEmpty else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        if let response = try? await search.start() {
            self.searchResults = response.mapItems
        }
    }
}
