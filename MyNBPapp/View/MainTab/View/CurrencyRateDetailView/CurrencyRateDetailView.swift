//
//  CurrencyRateDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Charts
import Commons
import DataModels
import SwiftUI

struct CurrencyRateDetailView: View {
    
    @StateObject var viewModel: CurrencyRateDetailViewModel
    
    @State var showAverage: Bool = false
    @State var isExpand: Bool = false
    @State var hideSymbol: Bool = false
    @State var showWeekday: Bool = false
    @State var showMonth: Bool = false
    @State var showWeekOfYear: Bool = false
    
    var body: some View {
        VStack {
            createChartTitle(viewModel.exchange)
            HStack {
                createChartView(viewModel.exchange)
                currencyTable
            }
            option
        }
        .padding()
    }
    
    @ViewBuilder
    func createChartTitle(_ exchange: Exchange) -> some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading) {
                    Text(exchange.currency)
                        .textCase(.uppercase)
                        .font(.title)
                        .bold()
                    
                    Text("Kurs euro Strefa Euro NBP")
                        .font(.subheadline)
                        .bold()
                }
                Spacer()
                createActualCourseText(exchange)
                createExchangeRateDifferenceText(exchange)
                createCurrencyFluctuationText(exchange)
            }
            .opacity(viewModel.selectedDate == nil  ? 1.0 : 0.0)
        }
    }
        
    @ViewBuilder
    func createChartView(_ exchange: Exchange) -> some View {
        GroupBox {
            Chart {
                ForEach(exchange.rates.compactMap { $0 as? RatesA }, id: \.no) { data in
                    if hideSymbol {
                        createLineMark(data)
                    } else {
                        createLineMarkWithSymbol(data)
                    }
                    createAreaMark(data)
                    if showAverage {
                        createRuleMark(data)
                    }
                    if let date = viewModel.selectedDate {
                        createRuleMark(selectedDate: date)
                            .annotation(position: .top,
                                        spacing: 0,
                                        overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                                annotationSelectionView
                            }
                    }
                }
            }
            .chartYScale(domain: viewModel.minMidValue - 0.01...(viewModel.maxMidValue + 0.01))
            .chartXSelection(value: $viewModel.selectedDate)
            .chartXAxis {
                if showWeekday {
                    AxisMarks(values: .stride(by: .day)) { _ in
                        AxisTick()
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.weekday(.narrow), centered: true)
                    }
                } else if showMonth {
                    AxisMarks(position: .top, values: .stride(by: .month)) {
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.month(.wide))
                    }
                } else if showWeekOfYear {
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
    }
    
    
    @ViewBuilder
    var currencyTable: some View {
        GroupBox {
            VStack {
                Spacer()
                Text("Tabela")
                Spacer()
            }
            .frame(width: 200)
        }
    }
    
    @ViewBuilder
    var option: some View {
        List {
            Section {
                Group {
                    Toggle(isOn: $showAverage) { Text("Pokaż średni kurs") }
                    Toggle(isOn: $hideSymbol) { Text("Ukryj symbol") }
                    Toggle(isOn: $showWeekday) { Text("Pokaż dni tygodnia") }
                    Toggle(isOn: $showMonth) { Text("Pokaż miesiące") }
                    Toggle(isOn: $showWeekOfYear) { Text("Pokaż numer tygodnia") }
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            } header: {
                Text("Opcje".uppercased())
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    func createActualCourseText(_ exchange: Exchange) -> some View {
        Group {
            if let actual = viewModel.actualRate {
                Text("\(actual, specifier: "%.3f") zł")
            } else {
                Text("brak danych")
                    .foregroundStyle(.red)
            }
        }
        .font(.title)
        .bold()
    }
    
    @ViewBuilder
    func createExchangeRateDifferenceText(_ exchange: Exchange) -> some View {
        let value = viewModel.yesterdayRatePercentageChange
        Text("\(value, specifier: "%.2f")%")
            .font(.title2)
            .foregroundStyle(value >= 0 ? .green : .red)
            .bold()
    }
    
    @ViewBuilder
    func createCurrencyFluctuationText(_ exchange: Exchange) -> some View {
        let value = viewModel.yesterdayRateValueChange
        Text("\(value, specifier: "%.4f") zł")
            .font(.title2)
            .foregroundStyle(value >= 0 ? .green : .red)
            .bold()
    }
    
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
            }
        }
    
    func createLineMarkWithSymbol(_ data: RatesA) -> some ChartContent {
        
        LineMark(
            x: .value("date", Formatters.Date.createDate(from: data.effectiveDate, with: .shortDate) ?? Date(), unit: .day),
            y: .value("value", data.mid)
        )
        .foregroundStyle(viewModel.yesterdayRateValueChange >= 0 ? Color("GreenChart") : .red)
        .opacity(showAverage == true ? 0.5 : 1 )
        .symbol(symbolPoint)
    }
    
    func createLineMark(_ data: RatesA) -> some ChartContent {
        LineMark(
            x: .value("date", Formatters.Date.createDate(from: data.effectiveDate, with: .shortDate) ?? Date() , unit: .day),
            y: .value("value", data.mid)
        )
        .foregroundStyle(viewModel.yesterdayRateValueChange >= 0 ? Color("GreenChart") : .red)
        .opacity(showAverage == true ? 0.5 : 1 )
    }
    
    func createAreaMark(_ data: RatesA) -> some ChartContent {
        AreaMark(
            x: .value("date", Formatters.Date.createDate(from: data.effectiveDate, with: .shortDate) ?? Date(), unit: .day),
            yStart: .value("mid", viewModel.difference(value: data.mid)),
            yEnd: .value("mid", data.mid )
        )
        .foregroundStyle(viewModel.yesterdayRateValueChange >= 0 ? Color("GreenChart") : .red)
        .opacity(showAverage == true ? 0.1 : 0.2 )
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
