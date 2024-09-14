//
//  DefaultMapViewsFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import Foundation
import SwiftUI

final class DefaultMapViewsFactory {
    
    @ViewBuilder
    func createMap(for type: MapType, viewModel: any MapViewModelProtocol) -> some View {
        switch type {
        case .swiftUIMap:
            SwiftUIMapView(viewModel: viewModel as! SwiftUIMapViewModel)
        case .uiKitMap:
            UIKitMapView(viewModel: viewModel as! UIKitMapViewModel)
        }
    }
}
