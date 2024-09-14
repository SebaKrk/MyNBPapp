//
//  SwiftUIMapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI
import MapKit

struct SwiftUIMapView: MapViewFactory, View {
    
    @ObservedObject var viewModel: SwiftUIMapViewModel
    
    init(viewModel: SwiftUIMapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        createMap()
    }
    
    func createMap() -> some View {
        Map(position: $viewModel.position, selection: $viewModel.mapSelection) {
            if !viewModel.searchResults.isEmpty {
                ForEach(viewModel.searchResults, id: \.self) { item in
                    Marker(item: item)
                        .tag(MapSelection(item))
                }
            }
        }
        .mapFeatureSelectionAccessory(.callout)
        .onChange(of: viewModel.searchResults) { oldValue, newValue in
            if let item = newValue.first {
                self.viewModel.centerMapOnItem(item)
            }
        }
        .onChange(of: viewModel.mapSelection) { oldValue, newValue in
            if let item = newValue?.value {
                self.viewModel.showDetails = self.viewModel.searchResults.contains(item)
            }
        }
        .onAppear {
            self.viewModel.manager.requestWhenInUseAuthorization()
            self.viewModel.manager.startUpdatingLocation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }

}

//
//class SwiftUIMapView: MapViewFactory {
//    
//    @ObservedObject var viewModel: SwiftUIMapViewModel
//    
//    init(viewModel: SwiftUIMapViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    func createMap() -> some View {
//        return Map(position: $viewModel.position, selection: $viewModel.mapSelection) {
//            if !viewModel.searchResults.isEmpty {
//                ForEach(viewModel.searchResults, id: \.self) { item in
//                    Marker(item: item)
//                        .tag(MapSelection(item))
//                }
//                /// pokazuje maly widok detali po zaznaczeniu
//                ///.mapItemDetailSelectionAccessory(.callout)
//            }
//        }
//        /// to nie dzila jesli w selecion nie damy MapSelection<MKMapItem>? samo MKMapItem nie dzila
//        .mapFeatureSelectionAccessory(.callout)
//        /// wypośrodkuj na pierwszym znalezionym elemencie
//        .onChange(of: viewModel.searchResults) { oldValue, newValue in
//            if let item = newValue.first {
//                self.viewModel.centerMapOnItem(item)
//            }
//        }
//        /// pokaz detale jeśli przyjdzie jakaś nowa wartość
//        .onChange(of: viewModel.mapSelection) { oldValue, newValue in
//            if let item = newValue?.value {
//                if self.viewModel.searchResults.contains(item) {
//                    self.viewModel.showDetails = true
//                } else {
//                    self.viewModel.showDetails = false
//                }
//                
//            }
//        }
//        /// zadanie autoryzacji dostępu do lokalizacji
//        .onAppear {
//            self.viewModel.manager.requestWhenInUseAuthorization()
//            self.viewModel.manager.startUpdatingLocation()
//            
//        }
//        .mapControls {
//            MapUserLocationButton()
//            MapCompass()
//            MapScaleView()
//        }
//    }
//    
//}
