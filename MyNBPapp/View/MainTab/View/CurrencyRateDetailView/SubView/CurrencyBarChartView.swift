//
//  CurrencyBarChartView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 05/04/2024.
//

import Charts
import Commons
import SwiftUI

struct CashExchangeChartView: View {
    
    @ObservedObject var viewModel: CurrencyRateDetailViewModel
    
    init(_ viewModel: CurrencyRateDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.chartType == .bid {
            createChartBid()
        } else if viewModel.chartType == .ask {
            createChartAsk()
        }
    }
    
    private func createChartBid() -> some View {
        Chart {
            ForEach(viewModel.dataC, id: \.no) { dataC in
                LineMark(
                    x: .value("date", Formatters.Date.createDate(from: dataC.effectiveDate, with: .shortDate) ?? Date() , unit: .day),
                    y: .value("value", dataC.bid)
                )
                .foregroundStyle(.orange)
                if viewModel.showAverage {
                    createRuleMarkBid()
                }
            }
        }
        .chartYScale(domain: viewModel.minBidValue - 0.01...(viewModel.maxBidValue + 0.01))
    }
    
    private func createChartAsk() -> some View {
        Chart {
            ForEach(viewModel.dataC, id: \.no) { dataC in
                LineMark(
                    x: .value("date", Formatters.Date.createDate(from: dataC.effectiveDate, with: .shortDate) ?? Date() , unit: .day),
                    y: .value("value", dataC.ask)
                )
                .foregroundStyle(.purple)
                if viewModel.showAverage {
                    createRuleMarkAsk()
                }
            }
        }
        .chartYScale(domain: viewModel.minAskValue - 0.01...(viewModel.maxAskValue + 0.01))
    }
    
    func createRuleMarkBid() -> some ChartContent {
        RuleMark(
            y: .value("Average", viewModel.averageBidValue)
        )
        .foregroundStyle(.gray)
        .annotation(position: .top, alignment: .leading) {
            Text("\(viewModel.averageBidValue, specifier: "%.3f")")
                .foregroundStyle(.gray)
        }
    }
    
    func createRuleMarkAsk() -> some ChartContent {
        RuleMark(
            y: .value("Average", viewModel.averageAskValue)
        )
        .foregroundStyle(.gray)
        .annotation(position: .top, alignment: .leading) {
            Text("\(viewModel.averageAskValue, specifier: "%.3f")")
                .foregroundStyle(.gray)
        }
    }
}
