//
//  MainCurrencyState.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Foundation

enum MainCurrencyState: Equatable, CaseIterable {
    
    case euro
    
    case dolar
    
    case funt
    
    case jen
    
    var title: String {
        switch self {
        case .euro: return "eur"
        case .dolar: return "usd"
        case .funt: return "gbp"
        case .jen: return "jpy"
        }
    }
}
