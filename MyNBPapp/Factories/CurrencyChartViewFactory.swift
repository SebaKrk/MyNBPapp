//
//  CurrencyChartViewFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import SwiftUI
import DataModels

final class CurrencyChartViewFactory: ChartViewFactory {
    
    @ViewBuilder
    func createCurrencyDetailsViews(chart type: ChartType,
                                    exchange: Exchange) -> some View {
        switch type {
        case .lineMark:
            let viewModel = CurrencyRateDetailViewModel(exchange: exchange)
            CurrencyRateDetailView(viewModel: viewModel)
        case .barMark:
            EmptyView()
        }
    }
}

