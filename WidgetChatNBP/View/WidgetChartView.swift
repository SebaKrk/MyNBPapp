//
//  WidgetChartView.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 28/04/2024.
//

import Charts
import WidgetKit
import SwiftUI

struct WidgetChartView: View {
    
    @Environment(\.widgetFamily) var widgetFamily
    var entry: WidgetProvider.Entry
    
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
                .chartYScale(domain: minMidValue - 0.01...maxMidValue + 0.01)
                .chartXAxis(.hidden)
                
                HStack {
                    Text("\(Date(), format: .dateTime)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .background(entry.widgetColor.color)
            .ignoresSafeArea()
            
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
            Text(entry.configuration?.currency.currency ?? "bład")
                .font(.title3)
                .textCase(.uppercase)
                .bold()
            Text(entry.configuration?.currency.subTitle ?? "bład")
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
    
    // MARK: - ChartContent
    
    func createLineMark(_ data: ChartData) -> some ChartContent {
        LineMark(
            x: .value("date", data.effectiveDate),
            y: .value("value", data.mid)
        )
        .foregroundStyle(yesterdayRateValueChange >= 0 ? .green : .red)
    }
    
    func createAreaMark(_ data: ChartData) -> some ChartContent {
        AreaMark(
            x: .value("date",  data.effectiveDate),
            yStart: .value("mid", difference(value: data.mid)),
            yEnd: .value("mid", data.mid )
        )
        .foregroundStyle(yesterdayRateValueChange >= 0 ? .green : .red)
        .opacity(0.2)
        .interpolationMethod(.linear)
    }
    
    
    // MARK: - Methods
    var minMidValue: Double {
        let midValues = entry.chartData.map { $0.mid }
        return midValues.min() ?? 0
    }
    
    var maxMidValue: Double {
        let midValues = entry.chartData.compactMap { $0 }.map { $0.mid }
        return midValues.max() ?? 0
    }
    
    var yesterdayRateValueChange: Double {
        guard let todayRate = entry.chartData.last?.mid,
              let yesterdayRate = entry.chartData.dropLast().last?.mid else {
            return 0
        }
        return todayRate - yesterdayRate
    }
    
    func difference(value: Double) -> Double {
        let numberToCompare = minMidValue - 0.01
        let difference = value - numberToCompare
        return value - difference
    }
}


//    var buttonDate: some View {
//        Button(intent: <#T##AppIntent#>) {
//            <#code#>
//        }
//    }
