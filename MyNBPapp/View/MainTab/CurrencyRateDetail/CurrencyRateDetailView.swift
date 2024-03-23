//
//  CurrencyRateDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Charts
import DataModels
import SwiftUI

struct CurrencyRateDetailView: View {
    
    var store: StoreOf<CurrencyRateDetailFeature>

    var body: some View {
        if let exchange = store.exchange {
            VStack {
                createChartTitle(exchange)
                HStack {
                    chartView
                    currencyTable
                }
                option
            }
            .padding()
        } else {
            Text("dupa")
        }
    }
    
    /// aktualny kurs z dnia dzisiejszego (najbardziej aktualny)
    @ViewBuilder
    func createChartTitle(_ exchange: Exchange) -> some View {
        GroupBox {
            HStack {
                Text(exchange.currency)
            }
        }
    }
    
    @ViewBuilder
    var chartView: some View {
        Chart {
            
        }
    }
    
    @ViewBuilder
    var currencyTable: some View {

        Text("Tabela")
    }
    
    @ViewBuilder
    var option: some View {
        List {
            Section {
                
            } header: {
                Text("Opcje".uppercased())
            }
        }
        .listStyle(.plain)
    }
    
}

//Table( ... ) {
//    TableColumn ( ... )
//}

// Sredni Kurs:
// Data poczatkowa
// Data Koncowa
// Zmiana %
// Zmiana PLN
// Minium
// Maximum
// Średnia w okresie
// Kupno
// Sprzedaż


//Text("1 EUR - EUFGiW")
//Spacer()
//Text("\(4.3031) zł")
//Text("-,049 %")
//Text("-0,0211 zl")
