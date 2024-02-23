//
//  MainViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import ExchangeRateClient
import MonumentKit
import SwiftUI

class MainViewModel: ObservableObject {
    
    let client: ExchangeRateClient
    @Published var nbp = MonumentData.nbp
    
    init(client: ExchangeRateClient) {
        self.client = client
    }
    
    func getCurrencyRateData() async {
        do {
            try await client.getData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
