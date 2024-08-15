
//
//  MapViewNewFuture.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/08/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
struct FindPlaceView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel = FindPlaceViewModel()
    let manager = CLLocationManager()

    // MARK: - Body
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .bottomTrailing) {
                map
                searchButton
                    .padding()
            }
            Spacer()
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
            SearchPlaceSheetView(items: $viewModel.searchResults)
        }
    }

    // MARK: - ViewBuilders

    private var map: some View {
        Map(position: $viewModel.position,
            selection: $viewModel.selection) {
            UserAnnotation()
            if !viewModel.searchResults.isEmpty {
                ForEach(viewModel.searchResults, id: \.self) { item in
                    Marker(item: item)
                        .tag(MapSelection(item))
                }
                .mapItemDetailSelectionAccessory(.callout)
                //.mapItemDetailSelectionAccessory()
            }

        }
        .mapFeatureSelectionAccessory(.callout)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .onAppear {
            manager.requestWhenInUseAuthorization()
        }
        .onChange(of: viewModel.searchResults) { oldValue, newValue in
            if let item = newValue.first {
                viewModel.centerMapOnItem(item)
            }
        }
        .onChange(of: viewModel.searchResults) { oldValue, newValue in
            if let firstItem = newValue.first {
                viewModel.selection = MapSelection(firstItem)
                viewModel.centerMapOnItem(firstItem)
            }
        }
        
    }
    
    private var searchButton: some View {
        Button {
            viewModel.isSheetPresented.toggle()
        } label: {
            Image(systemName: "magnifyingglass")
        }
        .opacity(viewModel.isSheetPresented ? 0 : 1)
        .foregroundStyle(.white)
        .padding()
        .background(.blue.opacity(0.9))
        .clipShape(Circle())
    }
}

@available(iOS 18.0, *)
struct FindPlaceSecondView: View {
    
    @State private var selection2: MKMapItem?
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var visitedStores: [MKMapItem] = []
    @State var isFavoritedPresented: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .bottomTrailing) {
                secondMap
                //searchButton
                    .padding()
            }
            Spacer()
        } 
        .toolbar {
            Button {
                isFavoritedPresented.toggle()
            } label: {
                Image(systemName: "star")
            }
        }
        .onAppear {
            addWawelToVisitedStores()
        }
        .sheet(isPresented: $isFavoritedPresented) {
            let wawelMapItem = createWawelMKMapItem()
            FavoriteList(favorite: [wawelMapItem])
        }
    }
    
    // MARK: - ViewBuilders
    
    private var secondMap: some View {
        Map(selection: $selection2) {
            ForEach(visitedStores, id: \.self) { store in
                Marker(item: store)
            }
            .mapItemDetailSelectionAccessory()
        }
    }
    
    // MARK: - API
    
    private func addWawelToVisitedStores() {
         let wawel = createWawelMKMapItem()
        wawel.name = "Wawel Sciuba"
         visitedStores.append(wawel)
     }
    
    func createWawelMKMapItem() -> MKMapItem {
        let coordinates = CLLocationCoordinate2D(latitude: 50.05431, longitude: 19.93635)
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Wawel"
        return mapItem
    }
}
