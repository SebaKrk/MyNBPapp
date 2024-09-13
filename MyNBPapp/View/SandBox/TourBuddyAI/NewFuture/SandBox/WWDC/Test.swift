//
//  Test.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 01/09/2024.
//

import Foundation

//@available(iOS 18.0, *)
//struct FindPlaceSecondView: View {
//    
//    @State private var selection2: MKMapItem?
//    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
//    @State private var visitedStores: [MKMapItem] = []
//    @State var isFavoritedPresented: Bool = false
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            ZStack(alignment: .bottomTrailing) {
//                secondMap
//                //searchButton
//                    .padding()
//            }
//            Spacer()
//        }
//        .toolbar {
//            Button {
//                isFavoritedPresented.toggle()
//            } label: {
//                Image(systemName: "star")
//            }
//        }
//        .onAppear {
//            addWawelToVisitedStores()
//        }
//        .sheet(isPresented: $isFavoritedPresented) {
//            let wawelMapItem = createWawelMKMapItem()
//            FavoriteList(favorite: [wawelMapItem])
//        }
//    }
//    
//    // MARK: - ViewBuilders
//    
//    private var secondMap: some View {
//        Map(selection: $selection2) {
//            ForEach(visitedStores, id: \.self) { store in
//                Marker(item: store)
//            }
//            .mapItemDetailSelectionAccessory()
//        }
//    }
//    
//    // MARK: - API
//    
//    private func addWawelToVisitedStores() {
//        let wawel = createWawelMKMapItem()
//        wawel.name = "Wawel Sciuba"
//        visitedStores.append(wawel)
//    }
//    
//    func createWawelMKMapItem() -> MKMapItem {
//        let coordinates = CLLocationCoordinate2D(latitude: 50.05431, longitude: 19.93635)
//        let placemark = MKPlacemark(coordinate: coordinates)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "Wawel"
//        return mapItem
//    }
//}

//guard let selection = viewModel.selection else { return }
//viewModel.scene = try await viewModel.fetchScene(for: selection.placemark.coordinate)
//Task {
//    ///await viewModel.fetchScene(for: selection.placemark.coordinate)
//    viewModel.fetchLookAroundPreview()
//}
//    }
//                    .onChange(of: viewModel.mapSelection) { oldValue, newValue in
//                        guard let selection = newValue else { return }
//                        Task {
//                            viewModel.fetchScene(for: selection.placemark.coordinate)
//                            ///viewModel.fetchLookAroundPreview()
//                        }
//                    }


// MARK: IOS18
//private var map: some View {
//    Map(position: $viewModel.position,
//        //interactionModes: viewModel.mapSelection == nil ? [.all] : [.zoom, .rotate],
//        selection: $viewModel.selection) {
//        UserAnnotation()
//        if !viewModel.searchResults.isEmpty {
//            ForEach(viewModel.searchResults, id: \.self) { item in
//                Marker(item: item)
                //.tag(MapSelection(item))
//            }
            //.mapItemDetailSelectionAccessory(.callout)
//        }
//
//    }
    //.mapFeatureSelectionAccessory(.callout)
//        .mapControls {
//            MapUserLocationButton()
//            MapCompass()
//            MapScaleView()
//        }
//        .onAppear {
//            manager.requestWhenInUseAuthorization()
//        }
//        .onChange(of: viewModel.searchResults) { oldValue, newValue in
//            if let item = newValue.first {
//                viewModel.centerMapOnItem(item)
//            }
//        }
//        .onChange(of: viewModel.selection) { oldValue, newValue in
//            viewModel.fetchLookAroundPreview()
//        }
//        .onAppear {
//            viewModel.fetchLookAroundPreview()
//        }
//        .overlay(alignment: .bottom) {
//            lookAroundView(scene: viewModel.scene)
//        }
    //            .onChange(of: viewModel.mapSelection) { oldValue, newValue in
    //                if newValue != nil {
    //                    dump(newValue)
    //                    if let selectedLocation = newValue {
    //                        if let item = selectedLocation.value {
    //                            Task {
    //                                viewModel.scene = try? await viewModel.fetchLookAroundScene(for: item)
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    
    //            .overlay(alignment: .bottom) {
    //                //if viewModel.mapSelection != nil, viewModel.scene != nil {
    //                if viewModel.mapSelection != nil {
    //                    LookAroundPreview(scene: $viewModel.scene, badgePosition: .bottomTrailing)
    //                        .frame(height: 150)
    //                        .clipShape(RoundedRectangle(cornerRadius: 12))
    //                        .safeAreaPadding(.bottom, 40)
    //                        .padding(.horizontal, 20)
    //                }
    //            }
//}
