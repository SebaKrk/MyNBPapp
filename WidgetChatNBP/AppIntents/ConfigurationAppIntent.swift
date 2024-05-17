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
    var subTitle: String
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget Currency"
    
    static var defaultQuery = CurrencyWidgetQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    
    static let allCurrency: [CurrencyWidget] = [
        CurrencyWidget(id: "euro", currency: "eur", subTitle: "Kurs euro Strefa Euro NBP"),
        CurrencyWidget(id: "dolar", currency: "usd", subTitle: "Kurs dolara Stany Zjednoczone NBP"),
        CurrencyWidget(id: "funt", currency: "gbp", subTitle: "Kurs funta Wielka Brytania NBP"),
        CurrencyWidget(id: "jen", currency: "jpy", subTitle: "Kurs jena Japonia NBP")
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
    
    @Parameter(title: "Accent Color")
    var accentColor: WidgetColor

}
