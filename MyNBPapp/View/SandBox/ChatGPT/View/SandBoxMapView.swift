//
//  SandBoxMapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/08/2024.
//

import SwiftUI

struct SandBoxMapView: View {
    
    var body: some View {
        checkAvailableSystem()
    }
    
    private func checkAvailableSystem() -> some View {
        if #available(iOS 17, *) {
            return MapView()
        } else if #available(iOS 18, *) {
            return MapViewNewFuture()
        }
    }
    
}
