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
        func createCurrencyDetailsViews(chart type: TableNBP,
                                        exchange: Exchange,
                                        cashExchangeRates: [RatesC],
                                        selectedPeriod: PeriodsCurrencyOption,
                                        isExpand: Bool) -> some View {
            switch type {
            case .a:
                let viewModel = CurrencyRateDetailViewModel(exchange: exchange,
                                                            cashExchangeRates: cashExchangeRates,
                                                            selectedPeriod: selectedPeriod,
                                                            isExpand: isExpand)
                CurrencyRateDetailView(viewModel: viewModel, chartType: type)
            case .c:
                EmptyView()
            }
        }
    

//    @ViewBuilder
//    func createCurrencyDetailsViews(chart type: ChartType,
//                                    exchange: Exchange,
//                                    cashExchangeRates: [RatesC],
//                                    selectedPeriod: PeriodsCurrencyOption,
//                                    isExpand: Bool) -> some View {
//        switch type {
//        case .lineMark:
//            let viewModel = CurrencyRateDetailViewModel(exchange: exchange,
//                                                        cashExchangeRates: cashExchangeRates,
//                                                        selectedPeriod: selectedPeriod,
//                                                        isExpand: isExpand)
//            CurrencyRateDetailView(viewModel: viewModel, chartType: type)
//        case .barMark:
//            EmptyView()
//        }
//    }
 
}
protocol ChartTypeTableViewFactory {
    
    associatedtype Content: View
    
    func createChartView(chart type: TableNBP, _ viewModel: CurrencyRateDetailViewModel) -> Content
}

final class CurrencyChartTypeTableViewFactory: ChartTypeTableViewFactory {
    
    @ViewBuilder
    func createChartView(chart type: TableNBP, _ viewModel: CurrencyRateDetailViewModel) -> some View {
        switch type {
        case .a:
            CurrencyChartView(viewModel)
        case .c:
            CashExchangeChartView(viewModel)
        default:
            EmptyView()
        }
    }
    
}

