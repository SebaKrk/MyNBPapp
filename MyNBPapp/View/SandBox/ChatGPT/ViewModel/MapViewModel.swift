//
//  MapViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/08/2024.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    
    let service = LocalSearchServices()
    let manager = CLLocationManager()
    
    @Published var places: [Place] = []
    @Published var searchResults: [MKMapItem] = []
    @Published var position: MapCameraPosition = .automatic
    @Published var selectResult: MKMapItem?
    @Published var selectTag: Int?
//    @Published var selectTag: String?
    @Published var wawel: MKMapItem?
    
    @Published var visibleRegion: MKCoordinateRegion?
    @Published var lookAroundScene: MKLookAroundScene?
    @Published var route : MKRoute?
    
    @Published var wawelRectangle: [CLLocationCoordinate2D]?
    
    @Published var monuments: [Monument] = [
        Monument(name: "Wawel", location: Location(latitude: 50.0547, longitude: 19.9352)),
        Monument(name: "MainSquare", location: Location(latitude: 50.0614, longitude: 19.9370)),
        Monument(name: "MarysBasilica", location: Location(latitude: 50.0616, longitude: 19.9390)),
        Monument(name: "Barbican", location: Location(latitude: 50.0654, longitude: 19.9421)),
        Monument(name: "Kazimierz", location: Location(latitude: 50.0480, longitude: 19.9445))
    ]
    
    func mapToMKMapItem(monument: Monument) -> MKMapItem {
         let placemark = MKPlacemark(coordinate: monument.location.coordinate)
         let mapItem = MKMapItem(placemark: placemark)
         mapItem.name = monument.name
         return mapItem
     }
    
    func mapPlaceToMKMapItem(place: Place) -> MKMapItem {
        let addressDict: [String: Any] = [
            "Street": place.placemark.address,
            "City": place.placemark.name,
            "Country": "Polska" // lub inny sposób na uzyskanie kraju
        ]
        
        let placemark = MKPlacemark(coordinate: place.placemark.coordinates, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = String(place.name)
        mapItem.phoneNumber = place.phoneNumber
        mapItem.url = place.url
        mapItem.timeZone = TimeZone(identifier: place.timeZone)
        
        return mapItem
    }
    
    @MainActor
    func search(for query: String) async {
         let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.0614, longitude: 19.9370),
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        )
        let search = MKLocalSearch(request: request)
        if let response = try? await search.start() {
            searchResults = response.mapItems
            print(searchResults)
        } else {
            searchResults = []
        }
     }
    
    @MainActor
    func findWawel() async throws {
        let wawelCastle = CLLocationCoordinate2D(latitude: 50.054, longitude: 19.935)
        
        do {
            wawel = try await service.searchPlace(center: wawelCastle)
        } catch {
            print("Error searching for monument: \(error)")
            throw NSError(domain: "error", code: 1)
        }
    }
    
    @MainActor
    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            guard let selectResult = selectResult else { return }
            let request = MKLookAroundSceneRequest(mapItem: selectResult)
            lookAroundScene = try? await request.scene
        }
    }
    
    @MainActor
    func getDirections() {
        route = nil
        guard let selectResult else { return }
        let wawelCastle = CLLocationCoordinate2D(latitude: 50.054, longitude: 19.935)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: wawelCastle))
        request.destination = selectResult

        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
    
    var travelTime: String? {
        guard let route = route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
    
    func printRegion() {
        print("▶️ \(String(describing: visibleRegion))")
    }
    
    func createRectangleAround(center: CLLocationCoordinate2D, halfWidth: Double, halfHeight: Double) -> [CLLocationCoordinate2D] {
        let topLeft = CLLocationCoordinate2D(latitude: center.latitude + halfHeight, longitude: center.longitude - halfWidth)
        let topRight = CLLocationCoordinate2D(latitude: center.latitude + halfHeight, longitude: center.longitude + halfWidth)
        let bottomRight = CLLocationCoordinate2D(latitude: center.latitude - halfHeight, longitude: center.longitude + halfWidth)
        let bottomLeft = CLLocationCoordinate2D(latitude: center.latitude - halfHeight, longitude: center.longitude - halfWidth)
        
        return [topLeft, topRight, bottomRight, bottomLeft, topLeft]
    }
    
    func createWawel() {
        let wawelCastle = CLLocationCoordinate2D(latitude: 50.054, longitude: 19.935)
        wawelRectangle = createRectangleAround(center: wawelCastle, halfWidth: 0.005, halfHeight: 0.003)
    }
}

