//
//  AppScreen.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    
    case fist
    case second
    case third
    
    var id: AppScreen { self }
    
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .fist:
            Label("first", systemImage: "chart.bar.doc.horizontal")
        case .second:
            Label("second", systemImage: "chart.bar.xaxis")
        case .third:
            Label("third", systemImage: "chart.pie.fill")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .fist:
            Text("first")
        case .second:
            Text("second")
        case .third:
            Text("third")
        }
    }
    
}
