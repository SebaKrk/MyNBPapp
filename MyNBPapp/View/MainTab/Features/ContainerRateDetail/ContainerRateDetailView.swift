//
//  ContainerRateDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import ComposableArchitecture
import Factory
import SwiftUI

struct ContainerRateDetailView: View {
    
    var store: StoreOf<ContainerRateDetailFeature>
    
    @Injected(\.chartViewFactory) private var viewFactory
    
    var body: some View {
        HStack {
            if let exchange = store.exchange {
                viewFactory.createCurrencyDetailsViews(chart: store.chartType,
                                                       exchange: exchange,
                                                       selectedPeriod: store.selectedPeriod,
                                                       isExpand: true)
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
            ForEach(ChartType.allCases, id: \.self) { item in
                Button {
                    store.send(.changeChartType(item))
                } label: {
                    Text(item.title)
                }
            }
        } label: {
            Image(systemName: "chart.bar")
        }
    }
    
    @ViewBuilder
    var selectedPeriod: some View {
        Text(store.selectedPeriod.title)
    }
    
}
