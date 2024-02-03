//
//  CurrencyRateViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import DataModels
import Factory
import Services
import SwiftUI

final class CurrencyRateViewModel: ObservableObject {
     
    @Injected(\.nbpService) private var nbpService
    @Published var exchange: Exchange?
    
    @MainActor
    func fetchData() async throws {
        do {
            exchange = try await nbpService.getEuroData()
            dump(exchange)
        } catch {
            print(error.localizedDescription)
        }
    }
}
