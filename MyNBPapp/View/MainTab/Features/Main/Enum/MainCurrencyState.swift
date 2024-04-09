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
    
    var subTitle: String {
        switch self {
        case .euro:
            return "Kurs euro Strefa Euro NBP"
        case .dolar:
            return "Kurs dolara Stany Zjednoczone NBP"
        case .funt:
            return "Kurs funta Wielka Brytania NBP"
        case .jen:
            return "Kurs jena Japonia NBP"
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
