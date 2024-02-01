//
//  CurrencyRateView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import DataModels
import Services
import SwiftUI

class CurrencyRateViewModel: ObservableObject {
    
    @Published var exchange: Exchange?
    
    let network: DefaultNetworkServiceNBP
    
    init(network: DefaultNetworkServiceNBP = DefaultNetworkServiceNBP() ) {
        self.network = network
    }
    
    @MainActor
    func fetchData() async throws {
        do {
            exchange = try await network.getEuroData()
            dump(exchange)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CurrencyRateView: View {
    
    @StateObject var viewModel = CurrencyRateViewModel()
    
    var body: some View {
        Text("CurrencyRateView")
            .onAppear {
                Task {
                    try await viewModel.fetchData()
                }
            }
    }
    
}
