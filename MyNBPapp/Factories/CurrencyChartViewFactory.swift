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
    func createCurrencyDetailsViews(chart type: ChartType,
                                    exchange: Exchange,
                                    cashExchangeRates: [RatesC],
                                    selectedPeriod: PeriodsCurrencyOption,
                                    isExpand: Bool) -> some View {
        switch type {
        case .lineMark:
            let viewModel = CurrencyRateDetailViewModel(exchange: exchange,
                                                        cashExchangeRates: cashExchangeRates,
                                                        selectedPeriod: selectedPeriod,
                                                        isExpand: isExpand)
            CurrencyRateDetailView(viewModel: viewModel)
        case .barMark:
            EmptyView()
        }
    }
}
