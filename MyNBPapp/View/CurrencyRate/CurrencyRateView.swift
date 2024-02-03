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
        Text("CurrencyRateView")
            .onAppear {
                Task {
                    try await viewModel.fetchData()
                }
            }
    }
    
}
