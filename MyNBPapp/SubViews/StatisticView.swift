//
//  StatisticView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import DataModels
import SwiftUI

struct StatisticView: View {
    
    var title: StatisticTitle
    var rate: Double
    var percentageChange: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.title)
                .font(.caption)
                .foregroundStyle(Color.secondary)
            HStack {
                Text("PLN")
                    .font(.headline)
                Text("\(rate, format: .number.precision(.fractionLength(3)))")
                    .font(.headline)
            }
          
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: percentageChange >= 0 ? 0 : 180)
                    )
                Text("\(percentageChange, format: .number.precision(.fractionLength(4))) %")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle( percentageChange >= 0 ? Color.green : Color.red)
        }
    }
    
}
