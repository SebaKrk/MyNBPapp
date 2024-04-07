//
//  CurrencyChartTypeViewFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/04/2024.
//

import SwiftUI

final class CurrencyChartTypeViewFactory: ChartTypeFactory {
    
    @ViewBuilder
    func createChartView(_ viewModel: CurrencyRateDetailViewModel) -> some View {
        switch viewModel.chartType {
        case .exchange:
            CurrencyChartView(viewModel)
        case .ask:
            CashExchangeChartView(viewModel)
        case .bid:
            CashExchangeChartView(viewModel)
        }
    }
    
}
