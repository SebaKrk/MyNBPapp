//
//  FindPlaceViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 11/08/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
class FindPlaceViewModel: ObservableObject {
    
    @Published var selection: MKMapItem?
    @Published var mapSelection: MapSelection<MKMapItem>?
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var isSheetPresented: Bool = false
    @Published var searchResults: [MKMapItem] = []
    @Published var scene: MKLookAroundScene?
    
    @Published var search: String = ""
    @Published var filteredResults: [MKMapItem] = []
    
    // MARK: - Methods
    
    func centerMapOnItem(_ item: MKMapItem) {
        guard let coordinate = item.placemark.location?.coordinate else { return }
        position = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
    }
    
    func fetchScene(for coordinate: CLLocationCoordinate2D) async throws -> MKLookAroundScene? {
        let lookAroundScene = MKLookAroundSceneRequest(coordinate: coordinate)
        return try await lookAroundScene.scene
    }
    
    func fetchLookAroundScene(for item: MKMapItem) async throws -> MKLookAroundScene? {
        let lookAroundScene = MKLookAroundSceneRequest(mapItem: item)
        
        return try await lookAroundScene.scene
    }
    
    @MainActor
    func fetchLookAroundPreview() {
        /*
        //if let mapSelection {
        if let selection {
            scene = nil
            //if let item = mapSelection.value {
                Task {
                    //let request =  MKLookAroundSceneRequest(mapItem: item)
                    let request =  MKLookAroundSceneRequest(mapItem: selection)
                    scene = try? await request.scene
                }
            //}
        }
         */
        scene = nil
        Task {
            guard let selectResult = selection else { return }
            let request = MKLookAroundSceneRequest(mapItem: selectResult)
            scene = try? await request.scene
        }
    }
    
    @MainActor
    func findPlace(place: String) async ->  [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        searchResults = response?.mapItems ?? []
        dump(searchResults)
        return searchResults
    }
    
}
