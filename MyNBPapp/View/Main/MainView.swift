//
//  MainView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import MonumentKit
import SwiftUI
import Charts

struct MainView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                createMonument()
                primaryInfoView()
            }
            .navigationTitle("Main")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    private func createMonument() -> some View {
        MonumentShowcaseView(monument: viewModel.nbp,
                             topSafeAreaInset: 0)
        .frame(height: horizontalSizeClass == .compact ? 150 : 200)
        .frame(maxWidth: .infinity)
        .cornerRadius(5)
        .padding([.leading, .trailing], 10)
    }
    
    private func primaryInfoView() -> some View {
        CurrencyRatePrimaryView()
            .padding([.leading, .trailing], 10)
    }
    
}
