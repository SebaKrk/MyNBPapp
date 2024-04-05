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
    
        func createCurrencyDetailsViews(chart type: TableNBP,
                                        exchange: Exchange,
                                        cashExchangeRates: [RatesC],
                                        selectedPeriod: PeriodsCurrencyOption,
                                        isExpand: Bool) -> Content
//
//    func createCurrencyDetailsViews(chart type: ChartType,
//                                    exchange: Exchange,
//                                    cashExchangeRates: [RatesC],
//                                    selectedPeriod: PeriodsCurrencyOption,
//                                    isExpand: Bool) -> Content
}
