//
//  PeriodsCurrencyOption.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/03/2024.
//

import Foundation

enum PeriodsCurrencyOption: Equatable, CaseIterable {
    
    case month
    case quoter
    case year
    
    var title: String {
        switch self {
        case .month: return "Miesiąc"
        case .quoter: return "Kwartał"
        case .year: return "Rok"
        }
    }
    
    var chartRangeStartDate: Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        switch self {
        case .month:
            return calendar.date(byAdding: .day, value: -30, to: currentDate)!
        case .quoter:
            return calendar.date(byAdding: .month, value: -3, to: currentDate)!
        case .year:
            return calendar.date(byAdding: .year, value: -1, to: currentDate)!
        }
    }
}
