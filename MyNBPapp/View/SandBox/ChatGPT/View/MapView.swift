//
//  MapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/07/2024.
//

import SwiftUI
import MapKit
import Contacts

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        Map(position: $viewModel.position,
            selection: $viewModel.selectResult) {
            ForEach(viewModel.searchResults, id: \.self) { result in
                Marker(item: result)
                    .tag(1)
                    //.tag(result.name)
            }
            
            ForEach(Place.samplePlaces, id: \.id) { place in
                Marker(item: viewModel.mapPlaceToMKMapItem(place: place))
                    .tag(2)
            }
            
            if let wawel = viewModel.wawel {
                Marker(item: wawel)
                    .tag(3)
            }
            
            UserAnnotation()
            
            if let route = viewModel.route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
            
            if let wawel = viewModel.wawelRectangle {
                MapPolygon(coordinates: wawel)
                    .foregroundStyle(.red.opacity(0.7))
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .padding()
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if let selectedResult = viewModel.selectResult {
                        lookAroundSceneView(scene: viewModel.lookAroundScene,
                                                      selectedResult: selectedResult,
                                                      travelTime: viewModel.travelTime)
                        .frame(height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding([.top, .horizontal])
                    }
                    HStack {
                        Spacer()
                        monumentButtonSearch
                        findMe
                        findWawel
                        Spacer()
                    }
                    .padding()
                }
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
        .onChange(of: viewModel.selectResult) {
            viewModel.getDirections()
        }
        .onAppear {
            viewModel.visibleRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 50.054, longitude: 19.935),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            viewModel.printRegion()
            viewModel.position = .region(viewModel.visibleRegion!)
        }
        .onMapCameraChange { context in
            viewModel.visibleRegion = context.region
            viewModel.position = .region(context.region)
            viewModel.printRegion()
        }
        .onAppear {
            viewModel.createWawel()
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
    
    func lookAroundSceneView(scene: MKLookAroundScene?, selectedResult: MKMapItem, travelTime: String?) -> some View {
        LookAroundPreview(initialScene: scene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text("\(selectedResult.name ?? "")")
                    if let travelTime = travelTime {
                        Text(travelTime)
                    }
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
            }
            .onAppear {
                viewModel.getLookAroundScene()
            }
            .onChange(of: viewModel.selectResult) {
                viewModel.getLookAroundScene()
            }
    }
    
}

#Preview {
    MapView(viewModel: MapViewModel())
}


//            ForEach(viewModel.monuments) { item in
//                Marker(item.name, coordinate: item.location.coordinate)
//                    .tag(item.id)
//            Marker(item: viewModel.mapToMKMapItem(monument: item))
//            }
//             $viewModel.selectResult






//var walkingCoordinates: [CLLocationCoordinate2D]
//
//let gradient = LinearGradient(
//    colors: [.red, .green, .blue],
//    startPoint: .leading, endPoint: .trailing
//)
//let stroke = StrokeStyle(
//    lineWidth: 5,
//    lineCap: .round, lineJoin: .round, dash: [10, 10]
//)
//
//var body: some View {
//    Map {
//        MapPolyline(coordinates: walkingCoordinates)
//            .stroke(gradient, style: stroke)
//    }
//}


//Map {
//    MapPolygon(coordinates: blackstoneSquare)
//        .foregroundStyle(.indigo.opacity(0.7))
//
//    MapPolygon(coordinates: franklinSquare)
//        .foregroundStyle(.teal.opacity(0.7))
//}

//Map {
//@Published var blackstoneSquareCenter = CLLocationCoordinate2D(latitude: 37.7790262, longitude: -122.4199061)
//@Published var blackstoneSquareRadius: CLLocationDistance = 100.0
//    MapCircle(
//        center: blackstoneSquareCenter,
//        radius: blackstoneSquareRadius
//    )
//    .foregroundStyle(.pink.opacity(0.75))
//    .mapOverlayLevel(level: .aboveRoads)
//
//    MapCircle(
//        center: franklinSquareCenter,
//        radius: franklinSquareRadius
//    )
//    .foregroundStyle(.cyan.opacity(0.75))
//    .mapOverlayLevel(level: .aboveLabels)
//}

//MapCircle(
//                    center: CLLocationCoordinate2D(latitude: 50.0654, longitude: 19.9421),
//                    radius: CLLocationDistance = 100.0
//                )
//                .foregroundStyle(.blue.opacity(0.7))
