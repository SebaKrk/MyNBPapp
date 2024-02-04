//
//  CurrencyRate+EuroChart.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import Charts
import SwiftUI

extension CurrencyRateView {
    
    @ViewBuilder
    var euroChart: some View {
        Chart {
            if let rates = viewModel.exchange?.rates {
                ForEach(rates, id: \.effectiveDate) { item in
                    AreaMark(
                        x: .value("Date", viewModel.convertDateToDay(item.effectiveDate)),
                        yStart: .value("Average rate", viewModel.difference(value: item.mid)),
                        yEnd: .value("Average rate", item.mid )
                    )
                    .foregroundStyle(Color("GreenChart").opacity(0.1).gradient)
                    
                    LineMark(
                        x: .value("Date", viewModel.convertDateToDay(item.effectiveDate)),
                        y: .value("Average rate", item.mid)
                    )
                    .foregroundStyle(Color("GreenChart"))
                }
            }
        }
        .chartYScale(domain: viewModel.minMidValue - 0.01...(viewModel.maxMidValue + 0.01))
        .frame(height: 250)
        .scaledToFit()
        .padding()
    }

}
