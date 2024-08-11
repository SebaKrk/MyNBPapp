//
//  FindPlaceViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 11/08/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
class FindPlaceViewModel: ObservableObject {
    
    @Published var selection: MapSelection<MKMapItem>?
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var isSheetPresented: Bool = false
    @Published var searchResults: [MKMapItem] = []
}
