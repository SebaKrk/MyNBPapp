//
//  GlobalCurrencySymbols.swift
//
//
//  Created by Sebastian Sciuba on 14/03/2024.
//

import Foundation

public enum GlobalCurrencySymbols: String, Equatable, CaseIterable {
    case polishZloty
    case dollar
    case yen
    case sterling
    case franc
    case euro
    case rupee
    case won
    case australianDollar
    case norwegianKrone
    case swedishKrona
    case danishKrone
    case brazilianReal
    case chineseYuanRenminbi
    
    public var title: String {
        switch self {
        case .polishZloty: return "PLN"
        case .dollar: return "USD"
        case .yen: return "JPY"
        case .sterling: return "GBP"
        case .franc: return "CHF"
        case .euro: return "EUR"
        case .rupee: return "INR"
        case .won: return "KRW"
        case .australianDollar: return "AUD"
        case .norwegianKrone: return "NOK"
        case .swedishKrona: return "SEK"
        case .danishKrone: return "DKK"
        case .brazilianReal: return "BRL"
        case .chineseYuanRenminbi: return "CNY"
        }
    }
    
    public var sfSymbol: String {
        switch self {
        case .polishZloty: return "polishzlotysign.circle"
        case .dollar: return "dollarsign.circle"
        case .yen: return "yensign.circle"
        case .sterling: return "sterlingsign.circle"
        case .franc: return "francsign.circle"
        case .euro: return "eurosign.circle"
        case .rupee: return "rupeesign.circle"
        case .won: return "wonsign.circle"
        case .australianDollar: return "australiandollarsign.circle"
        case .norwegianKrone: return "norwegiankronesign.circle"
        case .swedishKrona: return "swedishkronasign.circle"
        case .danishKrone: return "danishkronesign.circle"
        case .brazilianReal: return "brazilianrealsign.circle"
        case .chineseYuanRenminbi: return "chineseyuanrenminbisign.circle"
        }
    }
}
