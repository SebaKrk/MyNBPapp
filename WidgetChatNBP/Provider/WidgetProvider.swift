//
//  WidgetProvider.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 28/04/2024.
//

import Commons
import WidgetKit
import SwiftUI

struct WidgetProvider: TimelineProvider {
    
    func placeholder(in context: Context) ->  WidgetEntry {
        return WidgetEntry(date: Date(),
                           chartData: mockData)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        let entry = WidgetEntry(date: Date(),
                                chartData: mockData)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        
        let calendar = Calendar.current
        let fromDate = calendar.date(byAdding: .day, value: -30, to: currentDate)!
        
        WidgetNetworkManager.shared.getDataFromNBP(from: fromDate) { result in
            switch result {
            case .success(let exchange):
                let data = WidgetEntry(date: currentDate, chartData: exchange.rates)
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)
                
                let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
                
                completion(timeline)
                
            case .failure(let failure):
                let errorEntry = WidgetEntry(date: currentDate, chartData: [], statusMessage: "Error loading data: \(failure)")
                let retryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)
                let timeline = Timeline(entries: [errorEntry], policy: .after(retryDate!))
                completion(timeline)
            }
        }
    }
    
}
