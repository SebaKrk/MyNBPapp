//
//  SelectColorIntent.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 07/05/2024.
//

import AppIntents
import SwiftUI

struct WidgetColor: AppEntity {
    var id: String
    var color: Color
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget Color"
    static var defaultQuery = WidgetColorQuery()
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    
    static let allColors: [WidgetColor] = [
        WidgetColor(id: "clear", color: .clear),
        WidgetColor(id: "white", color: .white),
        WidgetColor(id: "red", color: .red),
        WidgetColor(id: "blue", color: .blue),
        WidgetColor(id: "orange", color: .orange)
    ]
}


struct WidgetColorQuery: EntityQuery {
    func entities(for identifiers: [WidgetColor.ID]) async throws -> [WidgetColor] {
        WidgetColor.allColors.filter {
            identifiers.contains($0.id)
        }
    }
    
    func suggestedEntities() async throws -> [WidgetColor] {
        WidgetColor.allColors
    }
    
    func defaultResult() async -> WidgetColor? {
        WidgetColor.allColors.first
    }
}

struct SelectColorIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Widget Accent Color"
    static var  description: IntentDescription = IntentDescription("select Widget Accent Color")
    
    @Parameter(title: "Accent Color")
    var accentColor: WidgetColor
}
