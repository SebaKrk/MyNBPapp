//
//  WidgetChartViewTimeLine.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 29/04/2024.
//


import Charts
import WidgetKit
import SwiftUI

struct WidgetChartViewTimeLine: View {
    
    @Environment(\.widgetFamily) var widgetFamily
    var entry: WidgetProviderWithTimeline.Entry
    
    var body: some View {
        if let statusMessage = entry.statusMessage {
            errorMessage(statusMessage)
        } else {
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
    }
    
    var switchTitle: some View {
        Group {
            switch widgetFamily {
            case .systemSmall:
                HStack {
                    Spacer()
                    Text("\(entry.chartData.last?.mid ?? 0, specifier: "%.3f") zł")
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
            Text("EURO")
                .font(.title3)
                .textCase(.uppercase)
                .bold()
            Text("Strefa Euro NBP")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text("\(entry.chartData.last?.mid ?? 0, specifier: "%.3f") zł")
                .font(.title3)
                .bold()
        }
    }
    
    func errorMessage(_ statusMessage: String) -> some View {
        Text(statusMessage)
            .padding()
            .multilineTextAlignment(.center)
            .foregroundColor(.red)
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
