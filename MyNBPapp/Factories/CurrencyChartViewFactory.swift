//
//  CurrencyChartViewFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import Commons
import DataModels
import SwiftUI

final class CurrencyChartViewFactory: ChartViewFactory {
    
        @ViewBuilder
        func createCurrencyDetailsViews(chart type: CurrencyExchangeChartType,
                                        exchange: Exchange,
                                        cashExchangeRates: [RatesC],
                                        selectedPeriod: PeriodsCurrencyOption,
                                        selectedCurrency: MainCurrencyState,
                                        isExpand: Bool) -> some View {
            switch type {
            case .exchange:
                let viewModel = CurrencyRateDetailViewModel(exchange: exchange,
                                                            cashExchangeRates: cashExchangeRates,
                                                            selectedPeriod: selectedPeriod,
                                                            chartType: type,
                                                            selectedCurrency: selectedCurrency,
                                                            isExpand: isExpand)
                CurrencyRateDetailView(viewModel: viewModel)
            default:
                EmptyView()
            }
        }
}
