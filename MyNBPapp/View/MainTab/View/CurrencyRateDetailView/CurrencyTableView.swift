//
//  CurrencyTableView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/04/2024.
//

import SwiftUI

struct CurrencyTableView: View {
    
    var body: some View {
        VStack {
            createCell("Średni kurs:", value: "4,2934 zł")
            createCell("Data początkowa:", value: "2023-03-31")
            createCell("Data końcowa:", value: "2024-03-29")
            createCell("Zmiana:", value: "-8,10%")
            createCell("Zmiana:", value: "-0,38 zł")
            createCell("Minimum:", value: "4,28 zł")
            createCell("Maksimum:", value: "4,69 zł")
            createCell("Średni w okresie:", value: "4,45 zł")
            createCell("Kupno:", value: "4,2579 zł")
            createCell("Sprzedaż:", value: "4,3439 zł")
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
