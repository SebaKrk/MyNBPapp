//
//  CurrencyRateDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Charts
import DataModels
import SwiftUI

struct CurrencyRateDetailView: View {

    @StateObject var viewModel: CurrencyRateDetailViewModel
    
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
        }
    }
    
    @ViewBuilder
    func createChartView(_ exchange: Exchange) -> some View {
        GroupBox {
            Chart {
                ForEach(exchange.rates.compactMap { $0 as? RatesA }, id: \.no) { data in
                    createLineMark(data)
                }
            }
            .chartYScale(domain: viewModel.minMidValue - 0.01...(viewModel.maxMidValue + 0.01))
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
    
    func createLineMark(_ data: RatesA) -> some ChartContent {
        LineMark(
            x: .value("date", data.effectiveDate),
            y: .value("value", data.mid))
    }
}
