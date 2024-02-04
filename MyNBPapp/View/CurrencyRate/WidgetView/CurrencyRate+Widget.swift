//
//  CurrencyRate+Widget.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import Charts
import SwiftUI

extension CurrencyRateView {
    
    @ViewBuilder
    var euroWidgetGroupBox: some View {
        GroupBox {
            VStack(alignment: .leading)  {
                HStack {
                    currentExchangeRate
                    Spacer()
                    euroStatisticView
                }
                Divider()
                euroChart
            }
        } label: {
            //Label("euro".uppercased(), systemImage: "chart.line.uptrend.xyaxis")
        }
        .padding()
    }
    
    @ViewBuilder
    var currentExchangeRate: some View {
        VStack(alignment: .leading) {
            Text("1 Euro")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(String(format: "%.2f Złoty", viewModel.currentExchangeRate))
                .font(.headline)
        }
        .padding()
    }
    
    
    @ViewBuilder
    var euroStatisticView: some View {
        HStack {
            lastDayStatistic
            thirtyDaysStatistic
        }
    }
    
    var lastDayStatistic: some View {
        StatisticView(title: .yesterday,
                      rate: viewModel.yesterdayRate,
                      percentageChange: viewModel.yesterdayRatePercentageChange)
        .padding(.trailing,10)
    }
    
    var thirtyDaysStatistic: some View {
        StatisticView(title: .last30Day,
                      rate: viewModel.thirtyDaysStatistic,
                      percentageChange: viewModel.thirtyDaysPercentageChange)
        .padding(.trailing,10)
    }
    
}
