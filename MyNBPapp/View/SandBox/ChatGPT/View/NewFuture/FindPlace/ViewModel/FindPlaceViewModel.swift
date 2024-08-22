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
    
    @Published var scene: MKLookAroundScene?
    @Published var selection: MKMapItem?
    @Published var search: String = ""
    @Published var showDetails: Bool = false
    
    @Published var mapSelection: MapSelection<MKMapItem>?
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var isSheetPresented: Bool = false
    @Published var searchResults: [MKMapItem] = []
    @Published var showSearchResults: Bool = false

    // MARK: - Methods
    
    func centerMapOnItem(_ item: MKMapItem) {
        guard let coordinate = item.placemark.location?.coordinate else { return }
        position = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)))
    }
    
    func fetchScene(for coordinate: CLLocationCoordinate2D) async throws -> MKLookAroundScene? {
        scene = nil
        let lookAroundScene = MKLookAroundSceneRequest(coordinate: coordinate)
        scene = try await lookAroundScene.scene
        return scene
    }
    
    @MainActor
    func fetchScene() async throws -> MKLookAroundScene? {
        guard let coordinate = selection?.placemark.coordinate else { return  nil}
        scene = nil
        let lookAroundScene = MKLookAroundSceneRequest(coordinate: coordinate)
        scene = try await lookAroundScene.scene
        return scene
    }
    
    func fetchLookAroundScene(for item: MKMapItem) async throws -> MKLookAroundScene? {
        let lookAroundScene = MKLookAroundSceneRequest(mapItem: item)
        
        return try await lookAroundScene.scene
    }
    
    @MainActor
    func fetchLookAroundPreview() {
     
        scene = nil
        Task {
            guard let selectResult = selection else { return }
            let request = MKLookAroundSceneRequest(mapItem: selectResult)
            scene = try? await request.scene
        }
        
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
    
    var searchResultsCount: Int {
        searchResults.count
    }
    
}