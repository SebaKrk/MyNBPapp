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
        
        getDataFromNBP(from: fromDate) { exchange in
            let data = WidgetEntry(date: currentDate, chartData: exchange.rates)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)
            
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))

            completion(timeline)
        }
    }
    
}

func getDataFromNBP(from: Date, completion: @escaping (Exchange) -> ()) {
    let fromDate = Formatters.Date.createString(from: from, with: .shortDate)
    let today = Formatters.Date.createString(from: Date(), with: .shortDate)
    
    let endpoint = "https://api.nbp.pl/api/exchangerates/rates/a/eur/\(fromDate)/\(today)/?format=json"
    
    guard let url = URL(string: endpoint) else { return }
    let session = URLSession(configuration: .default)
    session.dataTask(with: url) { (data, _, error) in
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        
        do {
            let jsonData = try JSONDecoder().decode(Exchange.self, from: data!)
            completion(jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    .resume()
    
}
