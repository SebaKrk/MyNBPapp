//
//  MainView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import Charts
import ExchangeRateClient
import MonumentKit
import SwiftUI

struct MainView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject var viewModel = MainViewModel(client: ExchangeRateClient())
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ZStack {
                    Text("Beautiful Map Goes Here")
                        .hidden()
                        .frame(height: horizontalSizeClass == .compact ? 150 : 200)
                        .frame(maxWidth: .infinity)
                }
                .background(alignment: .bottom) {
                    createMonument()
                }
            }
            .navigationTitle("NBP")
        }
        
//        NavigationStack {
//            createMonument()
//            ScrollView {
//                primaryInfoView()
//                ForEach(viewModel.currencyRates, id: \.currency) { item in
//                    CurrencyRateCell(currency: item.currency, rate: item.rate)
//                        .padding([.leading, .trailing], 10)
//                }
//            }
//            .navigationTitle("NBP")
//        }
//        .onAppear {
//            Task {
//                await viewModel.getCurrencyRateData()
//            }
//        }
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
