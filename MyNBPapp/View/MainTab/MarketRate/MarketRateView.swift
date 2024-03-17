//
//  MarketRateView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/03/2024.
//

import SwiftUI

class MarketRateViewModel: ObservableObject {
    
    let service = DataTest()
    
    @Published var data: CurrencyRateTest?
    
    init() {
        getData()
    }
    
    func getData() {
        self.data = service.createFakeData()
    }
}


struct MarketRateView: View {
    
    @StateObject var viewModel = MarketRateViewModel()
    
    var body: some View {
        
        VStack {
            if let data = viewModel.data?.rates {
                ForEach(data, id: \.self) { rate in
                    createCell("BID", rate.bid)
                    createCell("ASK", rate.ask)
                    Text("Data: \(rate.effectiveDate)")
                }
            }
        }
        .frame(width: 150)
        
    }
    
    @ViewBuilder
    func createCell(_ item: String, _ value: Double) -> some View {
        VStack {
            HStack {
                Text(item)
                Spacer()
                Text("\(value)")
                    .bold()
            }
            Divider()
        }
        
    }
    
}

class DataTest {
    
    static let shared = DataTest()
    
    func createFakeData() -> CurrencyRateTest {
        return CurrencyRateTest(table: "C",
                                currency: "euro",
                                code: "EUR",
                                rates: [
                                    RateTest(no: "052/C/NBP/2024",
                                             effectiveDate: "2024-03-13",
                                             bid: 4.2507,
                                             ask: 4.3365)
                                ])
    }
}


struct CurrencyRateTest: Decodable, Hashable {
    
    let table: String
    let currency: String
    let code: String
    let rates: [RateTest]
    
}

struct RateTest: Decodable, Hashable {
    let no: String
    let effectiveDate: String
    let bid: Double
    let ask: Double
}




//https://api.nbp.pl/api/exchangerates/rates/c/eur/today/?format=json
// ostani kurs
// zmian %
// srednia // https://api.nbp.pl/api/exchangerates/rates/a/eur/today/?format=json
// min - bid
// max - ask
// data


//do wykresy z odstnaich 30 dni
// https://api.nbp.pl/api/exchangerates/rates/c/eur/last/30/?format=json
