//
//  CurrencyCellWithBalance.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import SwiftUI

struct CurrencyCellWithBalance: View {
    
    let country: String
    let currency: String
    var bidRate: Double
    var bidChange: Double
    var askRate: Double
    var askChange: Double

    var body: some View {
        HStack {
            CurrencyView(country: country, currency: currency)
            Spacer()
            CurrencyBalanceView(bidRate, bidChange)
            CurrencyBalanceView(askRate, askChange)
        }
    }
    
}
