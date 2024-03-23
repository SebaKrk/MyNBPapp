//
//  MainFeatureServicesCoordinator.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 22/03/2024.
//

import Commons
import DataModels
import Factory
import Foundation

/// Stores dependencies for `MainFeature` and keep them as lazy properties
class MainFeatureServicesCoordinator {
    
    // MARK: - Dependencies
    
    @Injected(\.nbpService) private var nbpService
    
    // MARK: API
    
    func getNBPData(table: TableNBP, symbol: GlobalCurrencySymbols, from: Date, to: Date) async throws  -> Exchange {
        try await nbpService.getDataFromNBP(table: table, symbol: symbol, from: from, to: to)
    }
    
}
