//
//  UIKitMapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI
import MapKit

class UIKitMapView: MapViewFactory {
    
    @ObservedObject var viewModel: UIKitMapViewModel
    
    init(viewModel: UIKitMapViewModel) {
        self.viewModel = viewModel
    }
    
    func createMap() -> some View {
        return MapViewRepresentable(viewModel: viewModel)
    }
}
