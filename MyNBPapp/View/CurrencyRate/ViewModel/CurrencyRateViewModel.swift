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

