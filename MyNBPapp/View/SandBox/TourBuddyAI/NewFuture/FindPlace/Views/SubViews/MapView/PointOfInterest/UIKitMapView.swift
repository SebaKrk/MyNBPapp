//
//  UIKitMapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI
import MapKit

struct UIKitMapView: MapViewFactory, View {
    
    @ObservedObject var viewModel: UIKitMapViewModel

    init(viewModel: UIKitMapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        createMap()
    }
    
    func createMap() -> some View {
        MapViewRepresentable(viewModel: viewModel)
    }
 
}

//class UIKitMapView: MapViewFactory {
//    
//    @ObservedObject var viewModel: UIKitMapViewModel
//    
//    init(viewModel: UIKitMapViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    func createMap() -> some View {
//        return MapViewRepresentable(viewModel: viewModel)
//    }
//}
