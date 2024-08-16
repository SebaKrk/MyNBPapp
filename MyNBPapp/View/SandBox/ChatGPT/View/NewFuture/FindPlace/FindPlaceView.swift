
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
            //Spacer()
            ZStack(alignment: .bottomTrailing) {
                map2
                //                searchButton
                //                    .padding()
            }
            //Spacer()
        }
        //        .sheet(isPresented: $viewModel.isSheetPresented) {
        //            SearchPlaceSheetView(items: $viewModel.searchResults)
        //        }
        /// albo sheet overlay TF (sandBox)
        .overlay(alignment: .top) {
            searchTextFieldTop
        }
        .onSubmit(of: .text) {
            print("search tekst \(viewModel.search)")
            Task {
                await viewModel.findPlace(place: viewModel.search)
            }
        }
        /// zaprezentuj sheet z podglądem detali
        .sheet(isPresented: $viewModel.showDetails) {
            LocationDetailsView(mapSelection: $viewModel.selection,
                                show: $viewModel.showDetails)
            .presentationDetents([.height(340)])
            .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
        }
    }
    
    // MARK: - ViewBuilders
    
    private var map2: some View {
        Map(position: $viewModel.position, selection: $viewModel.selection) {
            if !viewModel.searchResults.isEmpty {
                ForEach(viewModel.searchResults, id: \.self) { item in
                    Marker(item: item)
                }
            }
        }
        /// wypośrodkuj na pierwszym znalezionym elemencie
        .onChange(of: viewModel.searchResults) { oldValue, newValue in
            if let item = newValue.first {
                viewModel.centerMapOnItem(item)
            }
        }
        /// pokaz detale jesli przyjdzie jakas nowa wartosc
        .onChange(of: viewModel.selection) { oldValue, newValue in
            dump(newValue)
            viewModel.showDetails = newValue != nil
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
    
    
    private var map: some View {
        Map(position: $viewModel.position,
            //interactionModes: viewModel.mapSelection == nil ? [.all] : [.zoom, .rotate],
            selection: $viewModel.selection) {
            UserAnnotation()
            if !viewModel.searchResults.isEmpty {
                ForEach(viewModel.searchResults, id: \.self) { item in
                    Marker(item: item)
                    //.tag(MapSelection(item))
                }
                //.mapItemDetailSelectionAccessory(.callout)
            }
            
        }
        //.mapFeatureSelectionAccessory(.callout)
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
            .onChange(of: viewModel.selection) { oldValue, newValue in
                viewModel.fetchLookAroundPreview()
            }
            .onAppear {
                viewModel.fetchLookAroundPreview()
            }
            .overlay(alignment: .bottom) {
                lookAroundView(scene: viewModel.scene)
            }
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

struct Test: View {
    
    @State var batteryLevel: Double = 20
    
    var body: some View {
        Gauge(value: batteryLevel, in: 0...100) {
            Text("Battery Level")
        }
        .gaugeStyle(.automatic)
    }
}

#Preview {
    Test()
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

struct LocationDetailsView: View {
    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScene: MKLookAroundScene?
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(mapSelection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                
                Spacer()
                
                Button {
                    show.toggle()
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
                    .frame(height: 200)
            }
            Spacer()
        }
        .onAppear {
            print("View appeared")
            fetchLookAroundPreview()
        }
        .onChange(of: mapSelection) { oldValue, newValue in
            fetchLookAroundPreview()
        }
        .padding()
    }
    
    private func fetchLookAroundPreview() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
}
