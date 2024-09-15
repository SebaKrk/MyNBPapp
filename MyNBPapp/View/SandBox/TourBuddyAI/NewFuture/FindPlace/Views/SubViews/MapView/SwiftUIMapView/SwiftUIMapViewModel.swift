//
//  SwiftUIMapViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
class SwiftUIMapViewModel: ObservableObject, MapViewModelProtocol {
    
    // MARK: - Properties
    
    let manager = CLLocationManager()
    
    @Published var position: MapCameraPosition
    @Published var mapSelection: MapSelection<MKMapItem>?
    @Published var showDetails: Bool
    
    @Published var search: String = ""
    @Published var searchResults: [MKMapItem] = []
    
    init(position: MapCameraPosition = .userLocation(fallback: .automatic),
         mapSelection: MapSelection<MKMapItem>? = nil,
         searchResults: [MKMapItem] = [],
         showDetails: Bool = false) {
        self.position = position
        self.mapSelection = mapSelection
        self.searchResults = searchResults
        self.showDetails = showDetails
    }
    
    // MARK: - Methods
    
    var placemarks: [MKPlacemark] {
        return searchResults.map { $0.placemark }
    }
    
    func centerMapOnItem(_ item: MKMapItem) {
        guard let coordinate = item.placemark.location?.coordinate else { return }
        position = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)))
    }
    
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
