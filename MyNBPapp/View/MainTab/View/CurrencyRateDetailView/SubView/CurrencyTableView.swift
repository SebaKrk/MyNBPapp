//
//  CurrencyTableView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/04/2024.
//

import Commons
import DataModels
import SwiftUI

struct CurrencyTableView: View {
    
    @ObservedObject var viewModel: CurrencyRateDetailViewModel
    
    init(_ viewModel: CurrencyRateDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            createCell("Średni kurs:", value: String(format: "%.3f zł", viewModel.averageCurrencyRate))
            createCell("Zmiana:", value: String(format: "%.3f %%", viewModel.ratePercentageChange))
            createCell("Zmiana:", value: String(format: "%.3f zł", viewModel.rateValueChange))
            createCell("Minimum:", value: "\(viewModel.minMidValue) zł")
            createCell("Maksimum:", value: "\(viewModel.maxMidValue) zł")
            Divider()
            createCell("Średni w okresie:", value: String(format: "%.3f zł", viewModel.averageBidValue))
            createCell("Kupno:", value: "\(viewModel.actualBid) zł")
            createCell("Sprzedaż:", value: "\(viewModel.actualAsk) zł")
            createCell("Minimum (Bid):", value: "\(viewModel.minBidValue) zł")
            createCell("Maksimum (Bid):", value: "\(viewModel.maxBidValue) zł")
        }
    }
    
    @ViewBuilder
    func createCell(_ title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .bold()
                .foregroundStyle(.primary)
        }
    }
}
