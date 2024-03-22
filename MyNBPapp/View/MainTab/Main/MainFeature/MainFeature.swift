//
//  MainFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import ComposableArchitecture
import SwiftUI

/// `MainFeature+Reducer`
@Reducer
struct MainFeature {
    
    // MARK: - Properties
    
    let service = MainFeatureServicesCoordinator()
    
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        CombineReducers {
            Reduce { state, action in
                switch action {
                case let .view(.selectedCurrencySymbolChange(globalSymbols)):
                    state.selectedCurrencySymbol = globalSymbols
                    return .none
                    
                case let .selectedCurrencyTabChange(selectedCurrency):
                    state.selectedCurrency = selectedCurrency
                    return .none
                    
                case let .selectedTabChange(selectedTab):
                    state.selectedTransitionTab = selectedTab
                    return .none
                    
                case .view(.viewDidAppear):
                    return .run { send in
                        let x = try await service.getNBPData(table: .a,
                                                             symbol: .euro,
                                                             from: Date(),
                                                             to: Date())
                        dump(x)
                    }
                    
                default: return .none
                }
            }
            Scope(state: \.currencyConverter, action: \.currencyConverter) {
                CurrencyConverterFeature()
            }
            .forEach(\.path, action: \.path) {
                CurrencyRateDetailFeature()
            }
        }
    }
    
}
