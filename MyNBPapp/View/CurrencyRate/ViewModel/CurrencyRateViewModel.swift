//
//  CurrencyRateViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import DataModels
import Factory
import Services
import SwiftUI

final class CurrencyRateViewModel: ObservableObject {
     
    @Injected(\.nbpService) private var nbpService
    @Published var exchange: Exchange?
    
    @MainActor
    func fetchData() async throws {
        do {
            exchange = try await nbpService.getEuroData()
            dump(exchange)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var minMidValue: Double {
        return exchange?.rates.min(by: { $0.mid < $1.mid })?.mid ?? 0
    }
    
    var maxMidValue: Double {
        return exchange?.rates.max(by: { $0.mid < $1.mid })?.mid ?? 0
    }
    
    var currentExchangeRate: Double {
        guard let lastExchangeRate  = exchange?.rates.last?.mid else { return 0.0 }
        return lastExchangeRate
    }
    
    var yesterdayRate: Double {
        guard let rates = exchange?.rates else { return 0 }
        return rates[rates.count - 2].mid
    }
    
    var yesterdayRatePercentageChange: Double {
        guard let rates = exchange?.rates, rates.count >= 2 else { return 0.0 }

        let lastRate = rates.last?.mid ?? 0.0
        let dayBeforeYesterdayRate = yesterdayRate

        if dayBeforeYesterdayRate == 0 { return 0.0 }

        let change = lastRate - dayBeforeYesterdayRate
        let percentageChange = (change / dayBeforeYesterdayRate) * 100
        return percentageChange
    }
    
    var thirtyDaysStatistic: Double {
        guard let rates = exchange?.rates else { return 0 }
        return rates.first?.mid ?? 0
    }
    
    var thirtyDaysPercentageChange: Double {
        guard let rates = exchange?.rates, let firstRate = rates.first?.mid, let lastRate = rates.last?.mid, firstRate != 0 else { return 0 }

        let change = lastRate - firstRate
        let percentageChange = (change / firstRate) * 100
        return percentageChange
    }
    
    func difference(value: Double) -> Double {
        let numberToCompare = minMidValue - 0.01
        let difference = value - numberToCompare
        return value - difference
    }
    
    func convertDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
}
