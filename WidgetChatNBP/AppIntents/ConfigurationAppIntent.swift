//
//  ConfigurationAppIntent.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 29/04/2024.
//

import AppIntents
import Commons
import Foundation

struct ConfigurationAppIntentNBP: WidgetConfigurationIntent, AppIntent {
    
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("Chart Widget Currency")

    @Parameter(title: "Waluta")
    var currency: Currency
    
//    @Parameter(title: "Date")
//    var date: Date
    
//    @MainActor
//    func perform() async throws -> some IntentResult {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let fromDate = calendar.date(byAdding: .day, value: -30, to: currentDate)!
//        
//        let exchange = try await WidgetNetworkManager.shared.getDataFromNBP(symbol: currency, from: fromDate)
//        
//        return .result()
//    }
    
    static var openAppWhenRun: Bool = true
    
}

enum Currency: String, Equatable, CaseIterable {
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

extension Currency: AppEnum {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Currency"
    
    static var caseDisplayRepresentations: [Currency : DisplayRepresentation] =  [
        .euro: "Euro",
        .dolar: "Dolar Amerykański",
        .funt: "Funt",
        .jen: "Jen"
    ]
    
}
