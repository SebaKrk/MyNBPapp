//
//  CurrencyExchangeChartType.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/04/2024.
//

import Foundation

enum CurrencyExchangeChartType: Equatable, CaseIterable  {
    
    case exchange
    case ask
    case bid
    
    var title: String {
        switch self {
        case .exchange: return "Kurs"
        case .ask: return "Sprzedaż"
        case .bid: return "Kupno"
        }
    }
}
