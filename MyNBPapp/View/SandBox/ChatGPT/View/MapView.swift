//
//  MapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/07/2024.
//

import SwiftUI
import MapKit
import Contacts

struct Monument: Identifiable, Hashable {
    var id: String { name }
    let name: String
    let location: Location
}

struct Location: Hashable{
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        Map(position: $viewModel.position, selection: $viewModel.selectTag) {
//            ForEach(viewModel.monuments) { item in
//                Marker(item.name, coordinate: item.location.coordinate)
//                    .tag(item.id)
//            Marker(item: viewModel.mapToMKMapItem(monument: item))
//            }
//             $viewModel.selectResult
            ForEach(viewModel.searchResults, id: \.self) { result in
                Marker(item: result)
                    .tag(result.name)
            }
            
            ForEach(Place.samplePlaces, id: \.id) { place in
                Marker(item: viewModel.mapPlaceToMKMapItem(place: place))
                    .tag(place.name)
            }
            
            if let wawel = viewModel.wawel {
                Marker(item: wawel)
                    .tag(wawel.name)
            }
            
            UserAnnotation()
                
        }

        .padding()
        ///.mapStyle(.imagery(elevation: .realistic))
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                monumentButtonSearch
                findMe
                findWawel
                    .padding()
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: viewModel.searchResults) {
            viewModel.position = .automatic
        }
        .onChange(of: viewModel.wawel) {
            viewModel.position = .automatic
        }
    }
    
    private var monumentButtonSearch: some View {
        Button {
            Task {
              await viewModel.search(for: "monument")
            }
        } label: {
            Label("monument", systemImage: "house")
        }
        .labelStyle(.iconOnly)
    }

    private var findMe: some View {
        Button {
            viewModel.manager.requestWhenInUseAuthorization()
        } label: {
            Label("Me", systemImage: "figure.wave")
        }
        .labelStyle(.iconOnly)
    }
    
    private var findWawel: some View {
        Button {
            Task {
                try await viewModel.findWawel()
            }
        } label: {
            Label("Wawel", systemImage: "figure.archery")
        }
        .labelStyle(.iconOnly)
    }
}

#Preview {
    MapView(viewModel: MapViewModel())
}

class MapViewModel: ObservableObject {

    let service = LocalSearchServices()
    let manager = CLLocationManager()
    
    @Published var places: [Place] = []
    @Published var searchResults: [MKMapItem] = []
    @Published var position: MapCameraPosition = .automatic
    @Published var selectResult: MKMapItem?
//    @Published var selectTag: Int?
    @Published var selectTag: String?
    @Published var wawel: MKMapItem?
    
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
    
}

#Preview {
    MapView()
}

extension CLLocationCoordinate2D {
    static let wawelCastle = CLLocationCoordinate2D(latitude: 50.0547, longitude: 19.9352)
    static let mainSquare = CLLocationCoordinate2D(latitude: 50.0614, longitude: 19.9370)
    static let stMarysBasilica = CLLocationCoordinate2D(latitude: 50.0616, longitude: 19.9390)
    static let barbican = CLLocationCoordinate2D(latitude: 50.0654, longitude: 19.9421)
    static let kazimierz = CLLocationCoordinate2D(latitude: 50.0480, longitude: 19.9445)
}
