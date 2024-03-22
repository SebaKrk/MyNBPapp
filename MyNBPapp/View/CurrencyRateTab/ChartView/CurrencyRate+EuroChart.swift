//
//  CurrencyRate+EuroChart.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import Charts
import SwiftUI
import DataModels

extension CurrencyRateView {
    
    @ViewBuilder
    var euroChart: some View {
        Chart {
            if let rates = viewModel.exchange?.rates {
                ForEach(rates, id: \.no) { rate in
                    if let item = rate as? RatesA {
                        LineMark(
                            x: .value("Date", item.effectiveDate),
                            y: .value("Mid", item.mid)
                        )
                        .foregroundStyle(Color("GreenChart"))
                        
                        AreaMark(
                            x: .value("Date", item.effectiveDate),
                            yStart: .value("Average rate", viewModel.difference(value: item.mid)),
                            yEnd: .value("Average rate", item.mid )
                        )
                        .foregroundStyle(Color("GreenChart"))
                        .opacity(0.1)
                        .interpolationMethod(.linear)
                    }
                }
            }
        }
        .chartYScale(domain: viewModel.minMidValue - 0.01...(viewModel.maxMidValue + 0.01))
        .frame(height: 250)
        .scaledToFit()
        .padding()
    }

}
