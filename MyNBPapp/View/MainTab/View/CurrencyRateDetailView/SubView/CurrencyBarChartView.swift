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
            }
        }
        .chartYScale(domain: viewModel.minAskValue - 0.01...(viewModel.maxAskValue + 0.01))
    }
}
