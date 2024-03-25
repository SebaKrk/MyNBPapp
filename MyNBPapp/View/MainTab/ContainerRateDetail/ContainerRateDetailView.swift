//
//  ContainerRateDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import ComposableArchitecture
import SwiftUI

struct ContainerRateDetailView: View {
    
    var store: StoreOf<ContainerRateDetailFeature>
    
    // TODO:  @Injected private
    var viewFactory: CurrencyChartViewFactory = CurrencyChartViewFactory()
    
    var body: some View {
        HStack {
            if let exchange = store.exchange {
                viewFactory.createCurrencyDetailsViews(chart: store.chartType,
                                                       exchange: exchange)
            }
        }
        .toolbar {
            toolbarButton
        }
    }
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            charTypeMenu
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
    
}
