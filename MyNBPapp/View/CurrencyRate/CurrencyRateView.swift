//
//  CurrencyRateView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI

struct CurrencyRateView: View {
    
    @StateObject var viewModel = CurrencyRateViewModel()
    
    var body: some View {
        ScrollView {
            euroWidgetGroupBox
        }
        .onAppear {
            Task {
                try await viewModel.fetchData()
            }
        }
    }
    
    @ViewBuilder
    var euroWidgetGroupBox: some View {
        GroupBox {
            euroChart
        } label: {
            Text("\(viewModel.minMidValue.rounded())")
        }
        .padding()
    }
    
}
