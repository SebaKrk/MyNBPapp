//
//  ContainerRateDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import ComposableArchitecture
import Commons
import Factory
import SwiftUI

struct ContainerRateDetailView: View {
    
    var store: StoreOf<ContainerRateDetailFeature>
    
    @Injected(\.chartViewFactory) private var viewFactory
    
    var body: some View {
        HStack {
            if let exchange = store.exchange, let cashExchangeRates = store.cashExchangeRates {
                let viewModel = CurrencyRateDetailViewModel(exchange: exchange,
                                                            cashExchangeRates: cashExchangeRates,
                                                            selectedPeriod: store.selectedPeriod,
                                                            chartType: store.chartType,
                                                            isExpand: true)
                CurrencyRateDetailView(viewModel: viewModel)
            }
        }
        .toolbar {
            toolbarButton
        }
    }
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            HStack {
                selectedPeriod
                charTypeMenu
            }
        }
    }
    
    @ViewBuilder
    var charTypeMenu: some View {
        Menu {
            ForEach(CurrencyExchangeChartType.allCases, id: \.self) { item in
                Button {
                    store.send(.changeChartType(item))
                } label: {
                    Text(item.title)
                }
            }
        } label: {
            Image(systemName: "chart.xyaxis.line")
        }
    }
    
    @ViewBuilder
    var selectedPeriod: some View {
        Text(store.selectedPeriod.title)
    }
    
}
