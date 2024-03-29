//
//  CurrencyRatePrimaryView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import SwiftUI

struct CurrencyRatePrimaryView: View {
    
    var body: some View {
        VStack {
            VStack {
                containerTile()
                    .padding(.bottom,15)
                VStack {
                        VStack {
                            CurrencyCellWithBalance(country: "usa", currency: "eur",
                                         bidRate: 4.3560, bidChange: 0.0021,
                                         askRate: 4.4451, askChange: -0.0031)
                            Divider()
                            CurrencyCellWithBalance(country: "usa", currency: "usd",
                                         bidRate: 3.3560, bidChange: 0.0051,
                                         askRate: 3.5451, askChange: -0.0021)
                            Divider()
                            CurrencyCellWithBalance(country: "usa", currency: "cny",
                                         bidRate: 0.4560, bidChange: 0.0031,
                                         askRate: 0.3451, askChange: -0.0011)
                        }
                }
            }
        }
        .padding()
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
    
    func containerTile() -> some View {
        HStack {
            Image("logoNBP")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            Text(String(localized: "National Bank of Poland").uppercased())
                .font(.title3)
                .bold()
            Spacer()
        }
    }
        
}
