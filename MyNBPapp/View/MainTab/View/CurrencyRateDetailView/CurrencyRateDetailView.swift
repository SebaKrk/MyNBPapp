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
    
    @ObservedObject var viewModel: CurrencyRateDetailViewModel

    var body: some View {
        if viewModel.isExpand {
            VStack {
                createExpandTitle(viewModel.exchange)
                HStack {
                    GroupBox {
                        VStack {
                            createChartView()
                                .chartXSelection(value: $viewModel.selectedDate)
                            Spacer()
                        }
                    }
                    currencyTable
                }
                option
            }
            .padding()
        } else {
            VStack {
                createTitle(viewModel.exchange)
                createChartView()
            }
        }
    }
    
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
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(exchange.currency)
                                .textCase(.uppercase)
                                .font(.title)
                                .bold()
                            
                            Text("Kurs euro Strefa Euro NBP")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        HStack {
                            createCell("Data początkowa:",
                                       value: Formatters.Date.createString(from:viewModel.selectedPeriod.chartRangeStartDate,
                                                                           with: .shortDate))
                            createCell("Data końcowa:",
                                       value: Formatters.Date.createString(from: Date(),
                                                                           with: .shortDate))
                        }
                    }
                    Spacer()
                    HStack {
                        createActualCourseText(exchange)
                        createExchangeRateDifferenceText(exchange)
                            .font(.title2)
                        createCurrencyFluctuationText(exchange)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func createChartView() -> some View {
        CurrencyChartView(viewModel)
    }
    
    @ViewBuilder
    var currencyTable: some View {
        GroupBox {
            VStack {
                Spacer()
                CurrencyTableView(viewModel)
                Spacer()
            }
            .frame(width: 250)
        }
    }
    
    @ViewBuilder
    var option: some View {
        List {
            Section {
                Group {
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
    func createCell(_ title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Text(value)
                .bold()
                .foregroundStyle(.primary)
        }
    }
}
