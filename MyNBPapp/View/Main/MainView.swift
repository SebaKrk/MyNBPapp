//
//  MainView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI
import MonumentKit

class MainViewModel: ObservableObject {
    
    @Published var nbp = MonumentData.nbp
    
}

struct MainView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ScrollView {
            createMonument()
        }
    }
    
    private func createMonument() -> some View {
        MonumentShowcaseView(monument: viewModel.nbp,
                             topSafeAreaInset: 0)
        .frame(height: horizontalSizeClass == .compact ? 150 : 200)
        .frame(maxWidth: .infinity)
        .cornerRadius(5)
        .padding([.leading, .trailing], 5)
    }
    
}
