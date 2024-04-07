//
//  MainCurrencyState.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Foundation
import Commons

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
    /// change to GlobalCurrencySymbol
    func changeGCSymbol() -> GlobalCurrencySymbols {
        switch self {
        case .euro:
            return .euro
        case .dolar:
            return .dolar
        case .funt:
            return .sterling
        case .jen:
            return .yen
        }
    }
}
