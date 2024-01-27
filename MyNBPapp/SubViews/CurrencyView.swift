//
//  CurrencyView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import SwiftUI

struct CurrencyView: View {
    
    let country: String
    let currency: String
    
    var body: some View {
        HStack {
            FlagView(name: country)
            Text("1 \(currency)".uppercased())
                .font(.headline)
        }
    }
    
}

