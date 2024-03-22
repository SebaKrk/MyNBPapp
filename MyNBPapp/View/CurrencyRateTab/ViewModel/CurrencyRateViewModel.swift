//
//  CurrencyRateViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import Commons
import DataModels
import Factory
import Services
import SwiftUI

final class CurrencyRateViewModel: ObservableObject {
    
    @Injected(\.nbpService) private var nbpService
    @Published var exchange: Exchange?
    
    @MainActor
    func fetchData(_ from: Date, to: Date) async throws {
        do {
            exchange = try await nbpService.getDataFromNBP(table: .a, symbol: .euro, from: from, to: to)
            dump(exchange)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var todayDate: Date {
        Date()
    }
    
    var dateMinus30days: Date {
        let currentDate = Date()
        let calendar = Calendar.current
        guard let thirtyDaysAgo = calendar.date(byAdding: .day, value: -30, to: currentDate) else {
            fatalError("Nie udało się obliczyć daty sprzed 30 dni.")
        }
        return thirtyDaysAgo
    }
    
    var minMidValue: Double {
        guard let rates = exchange?.rates else { return 0 }
        let midValues = rates.compactMap { $0 as? RatesA }.map { $0.mid }
        return midValues.min() ?? 0
    }
    
    var maxMidValue: Double {
        guard let rates = exchange?.rates else { return 0 }
          let midValues = rates.compactMap { $0 as? RatesA }.map { $0.mid }
          return midValues.max() ?? 0
    }
    
    var currentExchangeRate: Double {
        guard let rates = exchange?.rates.compactMap({ $0 as? RatesA }), let lastExchangeRate = rates.last?.mid else { return 0.0 }
        return lastExchangeRate
    }
    
    var yesterdayRate: Double {
        guard let rates = exchange?.rates.compactMap({ $0 as? RatesA }), rates.count >= 2 else { return 0 }
        return rates[rates.count - 2].mid
    }

    var yesterdayRatePercentageChange: Double {
        guard let rates = exchange?.rates.compactMap({ $0 as? RatesA }), rates.count >= 2 else { return 0.0 }
        let lastRate = rates.last?.mid ?? 0.0
        let dayBeforeYesterdayRate = rates[rates.count - 2].mid

        if dayBeforeYesterdayRate == 0 { return 0.0 }

        let change = lastRate - dayBeforeYesterdayRate
        let percentageChange = (change / dayBeforeYesterdayRate) * 100
        return percentageChange
    }
    
    var thirtyDaysStatistic: Double {
        guard let rates = exchange?.rates.compactMap({ $0 as? RatesA }), !rates.isEmpty else { return 0 }
        return rates.first?.mid ?? 0
    }

    var thirtyDaysPercentageChange: Double {
        guard let rates = exchange?.rates.compactMap({ $0 as? RatesA }), let firstRate = rates.first?.mid, let lastRate = rates.last?.mid, firstRate != 0 else { return 0 }

        let change = lastRate - firstRate
        let percentageChange = (change / firstRate) * 100
        return percentageChange
    }
    
    func difference(value: Double) -> Double {
        let numberToCompare = minMidValue - 0.01
        let difference = value - numberToCompare
        return value - difference
    }
    
    func convertDateToDay(_ dateString: String) -> String {
        if let date = Formatters.Date.createDate(from: dateString, with: .shortDate) {
            return Formatters.Date.createString(from: date, with: .day)
        } else {
            return ""
        }
    }
}
