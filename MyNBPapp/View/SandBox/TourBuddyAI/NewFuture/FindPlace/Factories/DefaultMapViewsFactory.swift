//
//  DefaultMapViewsFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import Foundation
import SwiftUI

final class DefaultMapViewsFactory {
    
    func createMap(for type: MapType) -> some View {
        switch type {
        case .swiftUIMap:
            let viewModel = SwiftUIMapViewModel()
            let map = SwiftUIMapView(viewModel: viewModel)
            return AnyView(map.createMap())
            
        case .uiKitMap:
            let viewModel = UIKitMapViewModel()
            let map = UIKitMapView(viewModel: viewModel)
            return AnyView(map.createMap())
        }
    }
    
}
