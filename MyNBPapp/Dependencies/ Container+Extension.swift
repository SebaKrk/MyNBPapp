//
//   Container+Extension.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 25/03/2024.
//

import Factory
import Foundation

extension Container {
    
    var chartViewFactory: Factory<CurrencyChartViewFactory> {
        Factory(self) { CurrencyChartViewFactory() }
    }
    
    var currencyChartTypeTableViewFactory: Factory<CurrencyChartTypeTableViewFactory> {
        Factory(self) { CurrencyChartTypeTableViewFactory() }
    }
    
    
}
