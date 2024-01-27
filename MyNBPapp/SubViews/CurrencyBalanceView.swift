//
//  CurrencyBalanceView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import SwiftUI

struct CurrencyBalanceView: View {
    
    var currentExchangeRate: Double
    var percentageChange: Double
    
    init(_ currentExchangeRate: Double, _ percentageChange: Double) {
        self.currentExchangeRate = currentExchangeRate
        self.percentageChange = percentageChange
    }
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            Text("\(currentExchangeRate, format: .number.precision(.fractionLength(4)))")
                .font(.headline)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: percentageChange >= 0 ? 0 : 180))
                    .foregroundStyle( percentageChange >= 0 ? Color.green : Color.red)
                
                Text("\(percentageChange >= 0 ? "+" : "")\(percentageChange, format: .number.precision(.fractionLength(3)))%")
                    .font(.caption)
            }
        }
    }
    
}
