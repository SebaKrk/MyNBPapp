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
    
    @Published var selection: MapSelection<MKMapItem>?
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var isSheetPresented: Bool = false
    @Published var searchResults: [MKMapItem] = []
    @Published var scene: MKLookAroundScene?
    
    
    // MARK: - Methods
    
    func centerMapOnItem(_ item: MKMapItem) {
        guard let coordinate = item.placemark.location?.coordinate else { return }
        position = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
    
    func fetchScene(for coordinate: CLLocationCoordinate2D) async throws -> MKLookAroundScene? {
        let lookAroundScene = MKLookAroundSceneRequest(coordinate: coordinate)
        return try await lookAroundScene.scene
    }
    
    func fetchLookAroundScene(for item: MKMapItem) async throws -> MKLookAroundScene? {
        let lookAroundScene = MKLookAroundSceneRequest(mapItem: item)
        return try await lookAroundScene.scene
    }
    
}
