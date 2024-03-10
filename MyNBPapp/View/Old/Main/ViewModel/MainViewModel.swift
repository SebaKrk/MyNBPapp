//
//  MainViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import DataModels
import ExchangeRateClient
import MonumentKit
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    
    let client: ExchangeRateClient
    @Published var nbp = MonumentData.nbp
    @Published var currencyRates: [CurrencyRate] = []
    
    init(client: ExchangeRateClient) {
        self.client = client
    }
    
    func getCurrencyRateData() async {
        do {
            let ratesDictionary = try await client.getData()
            self.currencyRates = ratesDictionary.map { CurrencyRate(currency: $0.key, rate: $0.value) }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
