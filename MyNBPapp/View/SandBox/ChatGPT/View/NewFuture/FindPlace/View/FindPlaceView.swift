
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
            ZStack(alignment: .bottomTrailing) {
                mapType
                HStack {
                    if !viewModel.searchResults.isEmpty {
                        showsSearchResultsButton
                    }
                    Spacer()
                    mapTypeButton
                    //searchButton
                }
                .padding()
            }
            Spacer()
        }
        /// zaprezentuj sheet z wyszukiwarka
        //        .sheet(isPresented: $viewModel.isSheetPresented) {
        //            SearchPlaceSheetView(items: $viewModel.searchResults)
        //        }
        /// albo sheet overlay TF (sandBox)
        .overlay(alignment: .top) {
            searchTextFieldTop
        }
        .onSubmit(of: .text) {
            Task {
                await viewModel.findPlace(place: viewModel.search)
            }
        }
        /// zaprezentuj sheet z podglądem detali
        .sheet(isPresented: $viewModel.showDetails) {
            LocationDetailsView(mapSelection: $viewModel.mapSelection,
                                show: $viewModel.showDetails)
            .presentationDetents([.height(340)])
            .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
        }
        /// zaprezentuj listę wyszukanych miejsc
        .sheet(isPresented: $viewModel.showSearchResults) {
            SearchResultsListView(items: $viewModel.searchResults,
                                  title: viewModel.search,
                                  numberOfItem: viewModel.searchResultsCount)
                .presentationDetents([.height(150), .medium, .large])
                .presentationBackgroundInteraction(.enabled)
        }
    }
    
    // MARK: - ViewBuilders
    
    private var mapType: some View {
        if viewModel.isShowingSwiftUiMap {
            AnyView(map)
        } else {
            AnyView(mapView)
        }
    }
    
    private var mapView: some View {
        MapViewRepresentable(pointOfInterestCategories: [.museum, .store],
                             searchResults: viewModel.placemarks)
        .edgesIgnoringSafeArea(.all)
    }
    
    private var map: some View {
        Map(position: $viewModel.position, selection: $viewModel.mapSelection) {
            if !viewModel.searchResults.isEmpty {
                ForEach(viewModel.searchResults, id: \.self) { item in
                    Marker(item: item)
                        .tag(MapSelection(item))
                }
                /// pokazuje maly widok detali po zaznaczeniu
                ///.mapItemDetailSelectionAccessory(.callout)
            }
        }
        /// to nie dzila jesli w selecion nie damy MapSelection<MKMapItem>? samo MKMapItem nie dzila
        .mapFeatureSelectionAccessory(.callout)
        /// wypośrodkuj na pierwszym znalezionym elemencie
        .onChange(of: viewModel.searchResults) { oldValue, newValue in
            if let item = newValue.first {
                viewModel.centerMapOnItem(item)
            }
        }
        /// pokaz detale jeśli przyjdzie jakaś nowa wartość
        .onChange(of: viewModel.mapSelection) { oldValue, newValue in
            if let item = newValue?.value {
                if viewModel.searchResults.contains(item) {
                    viewModel.showDetails = true
                } else {
                    viewModel.showDetails = false
                }
                
            }
        }
        /// zadanie autoryzacji dostępu do lokalizacji
        .onAppear {
            manager.requestWhenInUseAuthorization()
        }
        //        .overlay(alignment: .bottom) {
        //            if viewModel.showDetails {
        //                if viewModel.scene != nil  {
        //                    lookAroundView(scene: viewModel.scene)
        //                        .onAppear {
        //                            Task { try await viewModel.fetchScene() }
        //                        }
        //                        .onChange(of: viewModel.selection) { oldValue, newValue in
        //                            Task { try await viewModel.fetchScene() }
        //                        }
        //                }
        //                else {
        //                    UnavailableView
        //                        .background(.white)
        //                }
        //            }
        //        }
    }
    
    @ViewBuilder
    private func lookAroundView(scene: MKLookAroundScene?) -> some View {
        LookAroundPreview(scene: $viewModel.scene, badgePosition: .bottomTrailing)
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .safeAreaPadding(.bottom, 40)
            .padding(.horizontal, 20)
    }
    
    private var UnavailableView: some View {
        ContentUnavailableView("Brak podglądu", systemImage: "eye.slash")
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .safeAreaPadding(.bottom, 40)
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var searchTextFieldTop: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for ...", text: $viewModel.search)
                .autocorrectionDisabled()
        }
        .padding(12)
        .background(.white)
        .cornerRadius(8)
        .foregroundColor(.primary)
        .padding()
        .shadow(radius: 20)
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
    
    private var showsSearchResultsButton: some View {
        Button {
            viewModel.showSearchResults.toggle()
        } label: {
            Text("\(viewModel.searchResultsCount)")
        }
        .opacity(viewModel.isSheetPresented ? 0 : 1)
        .foregroundStyle(.white)
        .padding()
        .background(.blue.opacity(0.9))
        .clipShape(Circle())
    }
    
    private var mapTypeButton: some View {
        Button {
            viewModel.isShowingSwiftUiMap.toggle()
        } label: {
            Image(systemName: "swift")
        }
        .foregroundStyle(viewModel.isShowingSwiftUiMap ? .black : .white)
        .padding()
        .background(viewModel.isShowingSwiftUiMap ? .blue : .orange).opacity(0.7)
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
