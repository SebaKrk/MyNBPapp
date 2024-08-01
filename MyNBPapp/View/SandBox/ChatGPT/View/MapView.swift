//
//  MapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/07/2024.
//

import SwiftUI
import MapKit

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
    let manager = CLLocationManager()

    var body: some View {
        Map(position: $viewModel.position, selection: $viewModel.selectTag) {
            ForEach(viewModel.monuments) { item in
                Marker(item.name, coordinate: item.location.coordinate)
                    .tag(item.id)
            //Marker(item: viewModel.mapToMKMapItem(monument: item))
            }
             //$viewModel.selectResult
            ForEach(viewModel.searchResults, id: \.self) { result in
                Marker(item: result)
//                    .tag(result.name)
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
                    .padding()
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: viewModel.searchResults) {
            viewModel.position = .automatic
        }
        .onAppear {
            manager.requestWhenInUseAuthorization()
            
        }
    }
    
    private var monumentButtonSearch: some View {
        Button {
            viewModel.search(for: "monument")
        } label: {
            Label("monument", systemImage: "house")
        }
        .labelStyle(.iconOnly)
    }

}

#Preview {
    MapView(viewModel: MapViewModel())
}

class MapViewModel: ObservableObject {

    @Published var searchResults: [MKMapItem] = []
    @Published var position: MapCameraPosition = .automatic
    @Published var selectResult: MKMapItem?
    @Published var selectTag: String?
    
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
    
    @MainActor
    func search(for query: String) {
         let request = MKLocalSearch.Request()
         request.naturalLanguageQuery = query
         request.resultTypes = .pointOfInterest
         request.region = MKCoordinateRegion(
             center: CLLocationCoordinate2D(latitude: 50.0614, longitude: 19.9370),
             span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
         )
         
         Task {
             let search = MKLocalSearch(request: request)
             if let response = try? await search.start() {
                 searchResults = response.mapItems
                 print(searchResults)
             } else {
                 searchResults = []
             }
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
