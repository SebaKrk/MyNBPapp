//
//  CurrencyRateCell.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 25/02/2024.
//

import SwiftUI

struct CurrencyRateCell: View {
    
    let currency: String
    let rate: Double
    
    var body: some View {
        HStack {
            HStack {
                FlagView(name: "usa")
                Text("\(currency) / PLN".uppercased())
                    .font(.headline)
            }
            Spacer()
            Text("\(rate, format: .number.precision(.fractionLength(2)))")
                .font(.headline)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
    }
    
}
