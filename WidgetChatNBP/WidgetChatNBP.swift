//
//  WidgetChatNBP.swift
//  WidgetChatNBP
//
//  Created by Sebastian Sciuba on 23/04/2024.
//
import Charts
import WidgetKit
import SwiftUI

struct ChartData: Equatable, Hashable {
    let no: String
    let effectiveDate: String
    let mid: Double
}

struct WidgetEntry: TimelineEntry {
    let date: Date
    let chartData: [ChartData]
}

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
        var entries: [WidgetEntry] = []
        let currentDate = Date()
        
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WidgetEntry(date: Date(),
                                    chartData: mockData)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetChartView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: WidgetProvider.Entry
    
    
    var body: some View {
        VStack {
            switchTitle
            Chart {
                ForEach(entry.chartData, id: \.self) { data in
                    createLineMark(data)
                    createAreaMark(data)
                }
            }
            .chartYScale(domain: 4.22...4.36)
            .chartXAxis(.hidden)
        }
    }
    
    var switchTitle: some View {
        Group {
            switch widgetFamily {
            case .systemSmall:
                HStack {
                    Spacer()
                    Text("4,334 zł")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
            default:
                headerTitle
            }
        }
    }
    
    var headerTitle: some View {
        HStack {
            Text("Euro")
                .font(.title3)
                .textCase(.uppercase)
                .bold()
            Text("Strefa Euro NBP")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text("4,334 zł")
                .font(.title3)
                .bold()
        }
    }
    
    func createLineMark(_ data: ChartData) -> some ChartContent {
        LineMark(
            x: .value("date", data.effectiveDate),
            y: .value("value", data.mid)
        )
        .foregroundStyle(.green)
    }
    
    func createAreaMark(_ data: ChartData) -> some ChartContent {
        AreaMark(
            x: .value("date",  data.effectiveDate),
            yStart: .value("mid", 4.24),
            yEnd: .value("mid", data.mid )
        )
        .foregroundStyle(.green)
        .opacity(0.2)
        .interpolationMethod(.linear)
    }
}

struct WidgetChatNBP: Widget {
    let kind: String = "WidgetChatNBP"
    
    var body: some WidgetConfiguration {
         StaticConfiguration(kind: kind, provider: WidgetProvider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetChartView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WidgetChartView(entry: entry)
                    .padding()
                    .background()
            }
        }
         .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

#Preview(as: .systemSmall) {
    WidgetChatNBP()
} timeline: {
    WidgetEntry(date: .now,
               chartData: mockData)
}

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


