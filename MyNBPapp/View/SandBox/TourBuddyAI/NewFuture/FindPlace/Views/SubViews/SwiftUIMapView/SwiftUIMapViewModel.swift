//
//  SwiftUIMapViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
class SwiftUIMapViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let manager = CLLocationManager()
    
    @Published var position: MapCameraPosition
    @Published var mapSelection: MapSelection<MKMapItem>?
    @Published var searchResults: [MKMapItem]
    @Published var showDetails: Bool
    
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
    func findPlace(place: String) async ->  [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        searchResults = response?.mapItems ?? []
        return searchResults
    }
    
    var searchResultsCount: Int {
        searchResults.count
    }
    
}

//@Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
//@Published var mapSelection: MapSelection<MKMapItem>?
//@Published var searchResults: [MKMapItem] = []
//@Published var showDetails: Bool = false
