//
//  CurrencyRateView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI
import Commons

struct CurrencyRateView: View {
    
    @StateObject var viewModel = CurrencyRateViewModel()
    
    var body: some View {
        ScrollView {
            euroWidgetGroupBox
        }
        .onAppear {
            Task {
                try await viewModel.fetchData(viewModel.dateMinus30days, to: viewModel.todayDate)
            }
        }
    }
    
}
