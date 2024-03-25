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
                        
                case let .selectedCurrencyTabChange(selectedCurrency):
                    state.selectedCurrency = selectedCurrency
                    return .none
                    
                case let .selectedTabTransactionChange(selectedTab):
                    state.selectedTransitionTab = selectedTab
                    return .none
                    
                case let .updateExchangeData(data):
                    state.exchange = data
                    return .none
                    
                case let .view(.selectedCurrencySymbolChange(globalSymbols)):
                    state.selectedCurrencySymbol = globalSymbols
                    return .none
                    
                case let .view(.selectedCalendarCurrencyOptionChange(date)):
                    return .run { send in
                        let from = date.chartRangeStartDate
                        let today = Date()
                        let exchange = try await service.getNBPData(table: .a,
                                                                    symbol: .euro,
                                                                    from: from,
                                                                    to: today)
                        await send(.updateExchangeData(exchange))
                    }
                    
                case .view(.viewDidAppear):
                    return .run { [date = state.dateForm] send in
                        let from = date.chartRangeStartDate
                        let today = Date()
                        let exchange = try await service.getNBPData(table: .a,
                                                                    symbol: .euro,
                                                                    from: from,
                                                                    to: today)
                        await send(.updateExchangeData(exchange))
                    }
                    
                default: return .none
                }
            }
            Scope(state: \.currencyConverter, action: \.currencyConverter) {
                CurrencyConverterFeature()
            }
            .forEach(\.path, action: \.path) {
                ContainerRateDetailFeature()
            }
        }
    }
    
}
