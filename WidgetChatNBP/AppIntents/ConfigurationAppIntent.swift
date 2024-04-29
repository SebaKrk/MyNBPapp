//
//  ConfigurationAppIntent.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 29/04/2024.
//

import Foundation
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
    
    @Parameter(title: "cos", default: "😃")
    var cos: String
    
}
