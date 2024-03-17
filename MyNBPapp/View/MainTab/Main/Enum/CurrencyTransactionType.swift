//
//  CurrencyTransactionType.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Foundation

enum CurrencyTransactionType: Equatable, CaseIterable {
    
    case average
    
    case purchase
    
    case sale
    
    var title: String {
        switch self {
        case .average: return "Średni"
        case .purchase: return "Kupno"
        case .sale: return "Sprzedaż"
        }
    }
}
