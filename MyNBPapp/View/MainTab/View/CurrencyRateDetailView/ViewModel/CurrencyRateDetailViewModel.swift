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
    @Published var cashExchangeRates: [RatesC]
    
    @Published var selectedDate: Date? = nil
    @Published var isExpand: Bool = false
    @Published var selectedPeriod: PeriodsCurrencyOption = .month
    
    @Published var showAverage: Bool = false
    @Published var hideSymbol: Bool = false
    @Published var showWeekday: Bool = false
    @Published var showMonth: Bool = false
    @Published var showWeekOfYear: Bool = false
    
    @Published var chartType: CurrencyExchangeChartType
    @Published var selectedCurrency: MainCurrencyState
    
    init(exchange: Exchange,
         cashExchangeRates: [RatesC],
         selectedPeriod: PeriodsCurrencyOption,
         chartType: CurrencyExchangeChartType,
         selectedCurrency: MainCurrencyState,
         isExpand: Bool) {
        self.exchange = exchange
        self.cashExchangeRates = cashExchangeRates
        self.selectedPeriod = selectedPeriod
        self.chartType = chartType
        self.selectedCurrency = selectedCurrency
        self.isExpand = isExpand
    }
    
    var dataA: [RatesA] {
        exchange.rates.compactMap { $0 as? RatesA }
    }
    
    var dataC: [RatesC] {
        cashExchangeRates.compactMap { $0 }
    }

    var actualRate: Double? {
        dataA.last?.mid
    }
    
    var actualAsk: Double {
        dataC.last?.ask ?? 0
    }
    
    var actualBid: Double {
        dataC.last?.bid ?? 0
    }
    
    var yesterdayRateValueChange: Double {
        guard let todayRate = dataA.last?.mid,
              let yesterdayRate = dataA.dropLast().last?.mid else {
            return 0
        }
        return todayRate - yesterdayRate
    }
    
    var rateValueChange: Double {
        guard let lastRate = dataA.last?.mid,
              let firstRate = dataA.first?.mid
        else {
            return 0
        }
         return lastRate - firstRate
    }
    
    var ratePercentageChange: Double {
        guard let lastRate = dataA.last?.mid,
              let firstRate = dataA.first?.mid
        else {
            return 0
        }
         return (lastRate - firstRate) / firstRate * 100
    }

    var yesterdayRatePercentageChange: Double {
        guard let todayRate = dataA.last?.mid,
              let yesterdayRate = dataA.dropLast().last?.mid, yesterdayRate != 0 else {
            return 0
        }
        return (todayRate - yesterdayRate) / yesterdayRate * 100
    }
    
    var minMidValue: Double {
        let midValues = dataA.map { $0.mid }
        return midValues.min() ?? 0
    }
    
    var maxMidValue: Double {
        let midValues = dataA.compactMap { $0 }.map { $0.mid }
        return midValues.max() ?? 0
    }
    
    var minBidValue: Double {
        let bidValue = dataC.map { $0.bid }
        return bidValue.min() ?? 0
    }
    
    var maxBidValue: Double {
        let bidValue = dataC.map { $0.bid }
        return bidValue.max() ?? 0
    }
    
    var minAskValue: Double {
        let askValue = dataC.map { $0.ask }
        return askValue.min() ?? 0
    }
    
    var maxAskValue: Double {
        let askValue = dataC.map { $0.ask }
        return askValue.max() ?? 0
    }
    
    var averageBidValue: Double {
        let bidValues = dataC.map { $0.bid }
        guard !bidValues.isEmpty else { return 0 }
        let sumOfBids = bidValues.reduce(0, +)
        let averageBid = sumOfBids / Double(bidValues.count)
        return averageBid
    }
    
    var averageAskValue: Double {
        let askValues = dataC.map { $0.ask }
        guard !askValues.isEmpty else { return 0 }
        let sumOfAsks = askValues.reduce(0, +)
        let averageAsk = sumOfAsks / Double(askValues.count)
        return averageAsk
    }
    
    var averageCurrencyRate: Double {
        let midValues = dataA.compactMap { $0 }.map { $0.mid }
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
    
    func findMidValue(for searchDate: Date) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        let rates = exchange.rates.compactMap({ $0 as? RatesA })
        return rates.first { rate in
            guard let rateDate = dateFormatter.date(from: rate.effectiveDate) else { return false }
            return calendar.isDate(rateDate, inSameDayAs: searchDate)
        }?.mid
    }

}
