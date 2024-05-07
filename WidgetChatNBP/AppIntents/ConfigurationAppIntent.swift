//
//  ConfigurationAppIntent.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 29/04/2024.
//

import AppIntents
import Commons
import Foundation


struct CurrencyWidget: AppEntity {
    var id: String
    var currency: String
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget Currency"
    
    static var defaultQuery = CurrencyWidgetQuery()
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    
    static let allCurrency: [CurrencyWidget] = [
        CurrencyWidget(id: "EURO", currency: "eur"),
        CurrencyWidget(id: "DOLAR", currency: "usd"),
        CurrencyWidget(id: "FUNT", currency: "gbp"),
    ]
}

struct CurrencyWidgetQuery: EntityQuery {
    func entities(for identifiers: [CurrencyWidget.ID]) async throws -> [CurrencyWidget] {
        CurrencyWidget.allCurrency.filter {
            identifiers.contains($0.id)
        }
    }
    
    func suggestedEntities() async throws -> [CurrencyWidget] {
        CurrencyWidget.allCurrency
    }
    
    func defaultResult() async -> CurrencyWidget? {
        CurrencyWidget.allCurrency.first
    }
}

struct ConfigurationAppIntentNBP: WidgetConfigurationIntent {
    
    static var title: LocalizedStringResource = "Currency Widget"
    static var description = IntentDescription("Select Currency fot Chart Widget")

    @Parameter(title: "Waluta")
    var currency: CurrencyWidget
}


//enum Currency: String, Equatable, CaseIterable {
//    case euro
//    case dolar
//    case funt
//    case jen
//    
//    var title: String {
//        switch self {
//        case .euro: return "eur"
//        case .dolar: return "usd"
//        case .funt: return "gbp"
//        case .jen: return "jpy"
//        }
//    }
//    
//    var subTitle: String {
//        switch self {
//        case .euro:
//            return "Kurs euro Strefa Euro NBP"
//        case .dolar:
//            return "Kurs dolara Stany Zjednoczone NBP"
//        case .funt:
//            return "Kurs funta Wielka Brytania NBP"
//        case .jen:
//            return "Kurs jena Japonia NBP"
//        }
//    }
//    /// change to GlobalCurrencySymbol
//    func changeGCSymbol() -> GlobalCurrencySymbols {
//        switch self {
//        case .euro:
//            return .euro
//        case .dolar:
//            return .dolar
//        case .funt:
//            return .sterling
//        case .jen:
//            return .yen
//        }
//    }
//}
//
//extension Currency: AppEnum {
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Currency"
//    
//    static var caseDisplayRepresentations: [Currency : DisplayRepresentation] =  [
//        .euro: "Euro",
//        .dolar: "Dolar Amerykański",
//        .funt: "Funt",
//        .jen: "Jen"
//    ]
//    
//}
