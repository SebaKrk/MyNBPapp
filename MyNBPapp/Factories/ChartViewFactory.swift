//
//  ChartViewFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import Foundation
import DataModels
import Commons
import SwiftUI

protocol ChartViewFactory {
    
    associatedtype Content: View
    
        func createCurrencyDetailsViews(chart type: CurrencyExchangeChartType,
                                        exchange: Exchange,
                                        cashExchangeRates: [RatesC],
                                        selectedPeriod: PeriodsCurrencyOption,
                                        selectedCurrency: MainCurrencyState,
                                        isExpand: Bool) -> Content
}
