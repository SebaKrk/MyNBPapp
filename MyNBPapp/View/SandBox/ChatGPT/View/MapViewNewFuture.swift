//
//  MapViewNewFuture.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/08/2024.
//

import SwiftUI
import MapKit

struct SheetView: View {
    
    @State private var search: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for a restaurant", text: $search)
                    .autocorrectionDisabled()
            }
            .modifier(TextFieldGrayBackgroundColor())
            Spacer()
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(150), .medium])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        
    }
    
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}

struct VisitedStoresView: View {
    
    @State private var selection: MapSelection<MKMapItem>?
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    let manager = CLLocationManager()
    var visitedStores: [MKMapItem]?
    
    @State private var item: MKMapItem?
    @State private var museums: [MKMapItem]? = []

    
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                map
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        searchButton
                            .opacity(isSheetPresented ? 0 : 1)
                            .padding()
                    }
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView()
        }
    }
    
    private var searchButton: some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            Image(systemName: "magnifyingglass")
        }
        .foregroundStyle(.white)
        .padding()
        .background(.blue.opacity(0.9))
        .clipShape(Circle())
    }
    
    private var map: some View {
        Map(position: $position, selection: $selection) {
            UserAnnotation()
            if let item = item {
                Marker(item: item)
            }
            
            if let museums = museums {
                ForEach(museums, id: \.identifier) { museum in
                    Marker(item: museum)
                }
            }
        }
//        .mapFeatureSelectionAccessory(.callout)
//        .mapControls {
//            MapUserLocationButton()
//            MapCompass()
//            MapScaleView()
//        }
//        .onAppear {
//            manager.requestWhenInUseAuthorization()
//        }
//        .task {
//            await findWwa()
//        }
//        .task {
//            await findMuseumsInKrk()
//        }
    }
    
    private func findMuseumsInKrk() async {
        guard let krk = await findCity() else {
            return
        }
        museums = await findMuseums(in: krk)
    }
    
    private func findWwa() async {
        guard let wawa = await findCity() else {
            return
        }
        item = wawa
    }
    
    private func findCity() async -> MKMapItem? {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "krakow"
        
        request.addressFilter = MKAddressFilter(
            including: .locality
        )
        
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        return response?.mapItems.first
    }
    
    private func findMuseums(in city: MKMapItem ) async -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "museum"
        let downtown = MKCoordinateRegion(
            center: city.placemark.coordinate,
            span: .init(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
        request.region = downtown
        request.regionPriority = .required
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        return response?.mapItems ?? []
    }
}


//struct StoreList: View {
//    var stores: [MKMapItem]
//    @State private var selectedStore: MKMapItem?
//    
//    var body: some View {
//        List(
//            stores,
//            id: \.self,
//            selection: $selectedStore
//        ) {
//            Text($0.name ?? "Apple Store")
//        }
//        .mapItemDetailSheet(item: $selectedStore)
//    }
//}



struct MapViewNewFuture: View {
    var placeID: String // "I63802885C8189B2B"
    
    @State private var item: MKMapItem?
    @State private var selection: MKMapItem?
    
    var body: some View {
        Map(selection: $selection) {
            if let item {
                Marker(item: item)
                    .mapItemDetailSelectionAccessory()
            }
        }
        .task {
            guard let identifier = MKMapItem.Identifier(rawValue: placeID) else { return }
            let request = MKMapItemRequest(mapItemIdentifier: identifier)
            item = try? await request.mapItem
        }
    }
    
}
