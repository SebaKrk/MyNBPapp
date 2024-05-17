//
//  WidgetProvider.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 28/04/2024.
//

import Commons
import WidgetKit
import SwiftUI
import AppIntents

struct WidgetEntryConfiguration: TimelineEntry {
    let date: Date
    let chartData: [ChartData]
    var statusMessage: String?
    let configuration: ConfigurationAppIntentNBP?
    let widgetColor: WidgetColor
}


struct WidgetProvider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> WidgetEntryConfiguration {
        return WidgetEntryConfiguration(date: .now,
                                        chartData: mockData,
                                        configuration: ConfigurationAppIntentNBP(),
                                        widgetColor: WidgetColor.allColors[0])
    }
    
    func snapshot(for configuration: ConfigurationAppIntentNBP, in context: Context) async -> WidgetEntryConfiguration {
        WidgetEntryConfiguration(date: .now,
                                 chartData: mockData,
                                 configuration: configuration,
                                 widgetColor: configuration.accentColor)
    }
    
    func timeline(for configuration: ConfigurationAppIntentNBP, in context: Context) async -> Timeline<WidgetEntryConfiguration> {
        let currentDate = Date()
        let calendar = Calendar.current
        let fromDate = calendar.date(byAdding: .day, value: -30, to: currentDate)!
        
        do {
            let exchange = try await WidgetNetworkManager.shared.getDataFromNBP(from: fromDate,
                                                                                currency: configuration.currency.currency)
            let data = WidgetEntryConfiguration(date: currentDate,
                                                chartData: exchange.rates,
                                                configuration: configuration,
                                                widgetColor: configuration.accentColor)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)
            return Timeline(entries: [data], policy: .after(nextUpdate!))
        } catch {
            let errorEntry = WidgetEntryConfiguration(date: currentDate,
                                                      chartData: [],
                                                      statusMessage: "Async error loading data: \(error.localizedDescription)",
                                                      configuration: configuration,
                                                      widgetColor: WidgetColor.allColors[0])
            let retryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)
            return Timeline(entries: [errorEntry], policy: .after(retryDate!))
        }
    }
    
}
