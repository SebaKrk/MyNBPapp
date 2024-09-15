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
            self.viewModel.manager.requestAuthorization()
            self.viewModel.manager.startUpdatingLocation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        /// zaprezentuj sheet z podglądem detali
        .sheet(isPresented: $viewModel.showDetails) {
            locationDetailsSheet
        }
    }

    private var locationDetailsSheet: some View {
        LocationDetailsView(mapSelection: $viewModel.mapSelection,
                            show: $viewModel.showDetails)
        .presentationDetents([.height(340)])
        .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
    }

}
