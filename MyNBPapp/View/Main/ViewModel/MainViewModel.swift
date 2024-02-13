//
//  MainViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import Charts
import ExchangeRateClient
import MonumentKit
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var nbp = MonumentData.nbp
    
    let client: ExchangeRateClient
    
    init(client: ExchangeRateClient) {
        self.client = client
    }
    
}
