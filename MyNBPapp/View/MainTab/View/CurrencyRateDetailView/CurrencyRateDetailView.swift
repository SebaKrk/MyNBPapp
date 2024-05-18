//
//  CurrencyRateDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import Charts
import Commons
import DataModels
import SwiftUI
import Factory

struct CurrencyRateDetailView: View {
    
    // MARK: - Properties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var viewModel: CurrencyRateDetailViewModel
    @Injected(\.currencyChartTypeTableViewFactory) private var viewFactory
    
    // MARK: - View
    
    var body: some View {
        if viewModel.isExpand {
            if horizontalSizeClass == .compact {
                VStack {
                    ScrollView(.vertical) {
                        createExpandTitle(viewModel.exchange)
                        chartView
                        currencyTable
                            .frame(minWidth: 250)
                    }
                    option
                }
                .padding()
            } else {
                VStack {
                    createExpandTitle(viewModel.exchange)
                    HStack {
                        chartView
                        currencyTable
                            .frame(width:250)
                    }
                    option
                }
                .padding()
            }
        } else {
            VStack {
                createTitle(viewModel.exchange)
                createChartView()
            }
        }
    }
    
    // MARK: - ViewBuilder
    
    @ViewBuilder
    func createTitle(_ exchange: Exchange) -> some View {
        if let actual = viewModel.actualRate {
            VStack {
                Divider()
                    .padding(.top, 8)
                HStack {
                    Spacer()
                    Text("\(actual, specifier: "%.3f") zł")
                        .bold()
                    createExchangeRateDifferenceText(exchange)
                }
            }
        }
    }
    
    @ViewBuilder
    func createExpandTitle(_ exchange: Exchange) -> some View {
        GroupBox {
            if horizontalSizeClass == .compact {
                VStack(alignment: .leading) {
                    HStack {
                        currencyCell(exchange)
                        selectedCurrencyCell
                        Spacer()
                        infoButton
                    }
                    Spacer()
                    HStack {
                        Group {
                            createActualCourseText(exchange)
                            Spacer()
                            createExchangeRateDifferenceText(exchange)
                            createCurrencyFluctuationText(exchange)
                        }
                        .font(.subheadline)
                    }
                }
                
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        currencyCell(exchange)
                        selectedCurrencyCell
                        Spacer()
                        createActualCourseText(exchange)
                            .font(.title)
                    }
                    HStack {
                        dateCells
                        Spacer()
                        Group {
                            createExchangeRateDifferenceText(exchange)
                            createCurrencyFluctuationText(exchange)
                        }
                        .font(.title3)
                    }
                }
            }
        }
    }
    
    var chartView: some View {
        GroupBox {
            VStack {
                createChartView()
                    .chartXSelection(value: $viewModel.selectedDate)
                Spacer()
            }
        }
        .frame(minHeight: 300)
    }
    
    func createChartView() -> some View {
        viewFactory.createChartView(viewModel)
    }
    
    @ViewBuilder
    var currencyTable: some View {
        GroupBox {
            VStack {
                Spacer()
                CurrencyTableView(viewModel)
                Spacer()
            }
        }
    }
    
    var infoButton: some View {
        Menu {
            dateCells
        } label: {
            Image(systemName: "info.circle")
        }
    }
    
    @ViewBuilder
    var option: some View {
        List {
            Section {
                Group {
                    switch viewModel.chartType {
                    case .exchange:
                        exchangeOption
                    case .ask:
                        askOption
                    case .bid:
                        bidOption
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            } header: {
                Text("Opcje".uppercased())
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    var exchangeOption: some View {
        Toggle(isOn: $viewModel.showAverage) { Text("Pokaż średni kurs") }
        Toggle(isOn: $viewModel.hideSymbol) { Text("Ukryj symbol") }
        if viewModel.selectedPeriod == .month {
            Toggle(isOn: $viewModel.showWeekday) { Text("Pokaż dni tygodnia") }
        }
        if viewModel.selectedPeriod == .month || viewModel.selectedPeriod == .quoter {
            Toggle(isOn: $viewModel.showWeekOfYear) { Text("Pokaż numer tygodnia") }
        }
        Toggle(isOn: $viewModel.showMonth) { Text("Pokaż miesiące") }
    }
    
    @ViewBuilder
    var askOption: some View {
        Toggle(isOn: $viewModel.showAverage) { Text("Pokaż średni kurs") }
    }
    
    @ViewBuilder
    var bidOption: some View {
        Toggle(isOn: $viewModel.showAverage) { Text("Pokaż średni kurs") }
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
        .bold()
    }
    
    @ViewBuilder
    func createExchangeRateDifferenceText(_ exchange: Exchange) -> some View {
        let value = viewModel.yesterdayRatePercentageChange
        Text("\(value, specifier: "%.2f")%")
            .foregroundStyle(value >= 0 ? .green : .red)
            .bold()
    }
    
    @ViewBuilder
    func createCurrencyFluctuationText(_ exchange: Exchange) -> some View {
        let value = viewModel.yesterdayRateValueChange
        Text("\(value, specifier: "%.4f") zł")
            .foregroundStyle(value >= 0 ? .green : .red)
            .bold()
    }
    
    @ViewBuilder
    func dateCell(_ title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Text(value)
                .bold()
                .foregroundStyle(.primary)
        }
    }
    
    func currencyCell(_ exchange: Exchange) -> some View {
        Text(exchange.currency)
            .textCase(.uppercase)
            .font(.title)
            .bold()
    }
    var selectedCurrencyCell: some View {
        Text(viewModel.selectedCurrency.subTitle)
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    var dateCells: some View {
        HStack {
            dateCell("Data początkowa:",
                     value: Formatters.Date.createString(from: viewModel.selectedPeriod.chartRangeStartDate,
                                                         with: .shortDate))
            dateCell("Data końcowa:",
                     value: Formatters.Date.createString(from: Date(),
                                                         with: .shortDate))
        }
    }
    
}
