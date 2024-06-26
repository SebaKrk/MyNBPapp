//
//  WidgetChatNBP.swift
//  WidgetChatNBP
//
//  Created by Sebastian Sciuba on 23/04/2024.
//

import Commons
import Charts
import WidgetKit
import SwiftUI
import AppIntents

struct WidgetChatNBP: Widget {
    let kind: String = "WidgetChatNBP"
    
    var body: some WidgetConfiguration {
        if #available(iOS 17.0, *) {
            return AppIntentConfiguration(kind: kind,
                                          intent: ConfigurationAppIntentNBP.self,
                                          provider: WidgetProvider()) { entry in
                WidgetChartView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
                    .padding()
            }
                                          .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
                                          .contentMarginsDisabled()
            
        } else {
            return StaticConfiguration(kind: kind,
                                       provider: WidgetProviderWithTimeline()) { entry in
                WidgetChartViewTimeLine(entry: entry)
                    .padding()
                    .background()
            }
            .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        }
    }
}


//#Preview(as: .systemSmall) {
//    WidgetChatNBP()
//} timeline: {
//    WidgetEntry(date: .now,
//                chartData: mockData)
//}



let mockData: [ChartData] = [
    ChartData(no: "060/A/NBP/2024", effectiveDate: "2024-03-25", mid: 4.3091),
    ChartData(no: "061/A/NBP/2024", effectiveDate: "2024-03-26", mid: 4.3093),
    ChartData(no: "062/A/NBP/2024", effectiveDate: "2024-03-27", mid: 4.3153),
    ChartData(no: "063/A/NBP/2024", effectiveDate: "2024-03-28", mid: 4.3191),
    ChartData(no: "064/A/NBP/2024", effectiveDate: "2024-03-29", mid: 4.3009),
    ChartData(no: "065/A/NBP/2024", effectiveDate: "2024-04-02", mid: 4.2934),
    ChartData(no: "066/A/NBP/2024", effectiveDate: "2024-04-03", mid: 4.2923),
    ChartData(no: "067/A/NBP/2024", effectiveDate: "2024-04-04", mid: 4.2921),
    ChartData(no: "068/A/NBP/2024", effectiveDate: "2024-04-05", mid: 4.2883),
    ChartData(no: "069/A/NBP/2024", effectiveDate: "2024-04-08", mid: 4.2805),
    ChartData(no: "070/A/NBP/2024", effectiveDate: "2024-04-09", mid: 4.2588),
    ChartData(no: "071/A/NBP/2024", effectiveDate: "2024-04-10", mid: 4.2641),
    ChartData(no: "072/A/NBP/2024", effectiveDate: "2024-04-11", mid: 4.2649),
    ChartData(no: "073/A/NBP/2024", effectiveDate: "2024-04-12", mid: 4.2666),
    ChartData(no: "074/A/NBP/2024", effectiveDate: "2024-04-15", mid: 4.2851),
    ChartData(no: "075/A/NBP/2024", effectiveDate: "2024-04-16", mid: 4.3197),
    ChartData(no: "076/A/NBP/2024", effectiveDate: "2024-04-17", mid: 4.3353),
    ChartData(no: "077/A/NBP/2024", effectiveDate: "2024-04-18", mid: 4.3309),
    ChartData(no: "078/A/NBP/2024", effectiveDate: "2024-04-19", mid: 4.3316),
    ChartData(no: "079/A/NBP/2024", effectiveDate: "2024-04-22", mid: 4.3203),
    ChartData(no: "080/A/NBP/2024", effectiveDate: "2024-04-23", mid: 4.3335)
]


