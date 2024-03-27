//
//  CurrencyRateDetailViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import DataModels
import SwiftUI

class CurrencyRateDetailViewModel: ObservableObject {
    
    @Published var exchange: Exchange
    
    init(exchange: Exchange) {
        self.exchange = exchange
    }
    
//    shortDate
    
    
    var actualRate: Double? {
        exchange.rates.compactMap({ $0 as? RatesA }).last?.mid
    }
    
    var yesterdayRateValueChange: Double {
        guard let todayRate = (exchange.rates.last as? RatesA)?.mid,
              let yesterdayRate = (exchange.rates.dropLast().last as? RatesA)?.mid else {
            return 0
        }
        return todayRate - yesterdayRate
    }

    var yesterdayRatePercentageChange: Double {
        guard let todayRate = (exchange.rates.last as? RatesA)?.mid,
              let yesterdayRate = (exchange.rates.dropLast().last as? RatesA)?.mid, yesterdayRate != 0 else {
            return 0
        }
        return (todayRate - yesterdayRate) / yesterdayRate * 100
    }
    
    var minMidValue: Double {
        let midValues = exchange.rates.compactMap { $0 as? RatesA }.map { $0.mid }
        return midValues.min() ?? 0
    }
    
    var maxMidValue: Double {
        let midValues = exchange.rates.compactMap { $0 as? RatesA }.map { $0.mid }
        return midValues.max() ?? 0
    }
    
    var averageCurrencyRate: Double {
        let midValues = exchange.rates.compactMap { $0 as? RatesA }.map { $0.mid }
        guard !midValues.isEmpty else {
            return 0
        }
        let sum = midValues.reduce(0, +)
        return sum / Double(midValues.count)
    }
    
    func difference(value: Double) -> Double {
        let numberToCompare = minMidValue - 0.01
        let difference = value - numberToCompare
        return value - difference
    }
    
}
