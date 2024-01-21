//
//  AppScreen.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    
    case main
    case rate
    case favorites
    
    var id: AppScreen { self }
    
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .main:
            Label("Main", systemImage: "chart.bar.doc.horizontal")
        case .rate:
            Label("Rate", systemImage: "chart.line.uptrend.xyaxis")
        case .favorites:
            Label("Favorites", systemImage: "star")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .main:
            Text("Main")
        case .rate:
            Text("Rate")
        case .favorites:
            Text("Favorites")
        }
    }
    
}
