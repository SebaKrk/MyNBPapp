//
//  ColoredWidget.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 07/05/2024.
//

import WidgetKit
import SwiftUI

struct ColoredTimeline: AppIntentTimelineProvider {
    
    func timeline(for configuration: SelectColorIntent, in context: Context) async -> Timeline<ColoredEntry> {
        Timeline(entries: [ColoredEntry(date: .now, widgetColor: configuration.accentColor)], policy: .never)
    }
    
    func snapshot(for configuration: SelectColorIntent, in context: Context) async -> ColoredEntry {
        ColoredEntry(date: .now, widgetColor: configuration.accentColor)
    }
    
    func placeholder(in context: Context) -> ColoredEntry {
        ColoredEntry(date: .now, widgetColor: WidgetColor.allColors[0])
    }
}

struct ColoredEntry: TimelineEntry {
    let date: Date
    let widgetColor: WidgetColor
}

struct ColoredWidgetView: View {
    
    let entry: ColoredEntry
    
    var body: some View {
        entry.widgetColor.color
            .ignoresSafeArea()
    }
    
}

struct ColoredWidget: Widget {
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: "ColoredWidget",
            intent: SelectColorIntent.self,
            provider: ColoredTimeline()) { entry in
                ColoredWidgetView(entry: entry)
            }
            .configurationDisplayName("Colored Widget")
            .description("Displays a configurable Color.")
            .supportedFamilies([.systemSmall])
            .contentMarginsDisabled()
    }
    
}
