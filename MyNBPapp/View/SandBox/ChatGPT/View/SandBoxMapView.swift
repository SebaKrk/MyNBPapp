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
        if #available(iOS 18, *) {
            //return MapViewNewFuture(placeID: "I63802885C8189B2B")
            return VisitedStoresView()
        }
        else {
            return MapView()
        }
    }
    
}
