//
//  CurrencyChartView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 05/04/2024.
//

import Charts
import Commons
import DataModels
import SwiftUI

struct CurrencyChartView: View {
    
    @ObservedObject var viewModel: CurrencyRateDetailViewModel
    
    init(_ viewModel: CurrencyRateDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Chart {
            ForEach(viewModel.dataA, id: \.no) { data in
                if viewModel.hideSymbol || !viewModel.isExpand {
                    createLineMark(data)
                } else {
                    createLineMarkWithSymbol(data)
                }
                createAreaMark(data)
                if viewModel.showAverage {
                    createRuleMark(data)
                }
                if let date = viewModel.selectedDate {
                    createRuleMark(selectedDate: date)
                        .annotation(position: .trailing,
                                    spacing: 5,
                                    overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            annotationSelectionView
                        }
                }
            }
        }
        .chartYScale(domain: viewModel.minMidValue - 0.01...(viewModel.maxMidValue + 0.01))
        .chartXAxis {
            if viewModel.showWeekday {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisTick()
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.weekday(.narrow), centered: true)
                }
            } else if viewModel.showMonth {
                AxisMarks(position: .top, values: .stride(by: .month)) {
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month(.wide))
                }
            } else if viewModel.showWeekOfYear {
                AxisMarks(values: .stride(by: .weekOfYear)) { _ in
                    AxisTick()
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.week(.twoDigits), centered: true)
                }
            } else {
                AxisMarks() {
                    AxisTick()
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
        }
    }
    
    // MARK: - ViewBuilders
    
    @ViewBuilder
    var annotationSelectionView: some View {
        if let selectedDate = viewModel.selectedDate, let sales = viewModel.findMidValue(for: selectedDate) {
            VStack(alignment: .leading) {
                Text(Formatters.Date.createString(from: selectedDate, with: .shortDate))
                    .foregroundStyle(.secondary)
                    .fixedSize()
                HStack {
                    Text("kurs:")
                        .foregroundStyle(.secondary)
                    Text(sales, format: .number.precision(.fractionLength(4)))
                        .bold()
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(.regularMaterial)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
    
    //    MARK: - ChartContent
    
    func createLineMarkWithSymbol(_ data: RatesA) -> some ChartContent {
        LineMark(
            x: .value("date", Formatters.Date.createDate(from: data.effectiveDate, with: .shortDate) ?? Date(), unit: .day),
            y: .value("value", data.mid)
        )
        .foregroundStyle(viewModel.yesterdayRateValueChange >= 0 ? Color("GreenChart") : .red)
        .opacity(viewModel.showAverage == true ? 0.5 : 1 )
        .symbol(symbolPoint)
    }
    
    func createLineMark(_ data: RatesA) -> some ChartContent {
        LineMark(
            x: .value("date", Formatters.Date.createDate(from: data.effectiveDate, with: .shortDate) ?? Date() , unit: .day),
            y: .value("value", data.mid)
        )
        .foregroundStyle(viewModel.yesterdayRateValueChange >= 0 ? Color("GreenChart") : .red)
        .opacity(viewModel.showAverage == true ? 0.5 : 1 )
    }
    
    func createAreaMark(_ data: RatesA) -> some ChartContent {
        AreaMark(
            x: .value("date", Formatters.Date.createDate(from: data.effectiveDate, with: .shortDate) ?? Date(), unit: .day),
            yStart: .value("mid", viewModel.difference(value: data.mid)),
            yEnd: .value("mid", data.mid )
        )
        .foregroundStyle(viewModel.yesterdayRateValueChange >= 0 ? Color("GreenChart") : .red)
        .opacity(viewModel.showAverage == true ? 0.1 : 0.2 )
        .interpolationMethod(.linear)
    }
    
    func createRuleMark(_ data: RatesA) -> some ChartContent {
        RuleMark(
            y: .value("Average", viewModel.averageCurrencyRate)
        )
        .foregroundStyle(.gray)
        .annotation(position: .top, alignment: .leading) {
            Text("average currency rate: \(viewModel.averageCurrencyRate, specifier: "%.3f")")
                .font(.headline)
                .foregroundStyle(.gray)
        }
    }
    
    func createRuleMark(selectedDate: Date) -> some ChartContent {
        RuleMark(
            x: .value("Selected", selectedDate, unit: .day)
        )
        .foregroundStyle(Color.gray.opacity(0.3))
    }
    
    var symbolPoint: some ChartSymbolShape {
        Circle()
            .strokeBorder(lineWidth: 2)
    }
}
