//
//  MainFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import ComposableArchitecture
import DataModels
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
                    /// Średni / Kupno / Sprzedaż
                case let .selectedTabTransactionChange(selectedTab):
                    state.selectedTransitionTab = selectedTab
                    return .none
                    
                    /// Exchange tabelaA
                case let .updateExchangeData(data):
                    state.exchange = data
                    return .none
                    
                    /// Echange TabelaC
                case let .updateCashExchangeRatesData(dataC):
                    state.cashExchangeRates = dataC
                    return .none
                               
                    /// aktualizacja zakresu daty od - Miesiąc / Kwartał / Rok
                case let .updatePeriod(period):
                    state.dateForm = period
                    return .none
                    
                    
                case let .view(.selectedPeriodChange(date)):
                    return .run { [symbol = state.selectedCurrency] send in
                        let from = date.chartRangeStartDate
                        let today = Date()
                        let symbol = symbol.changeGCSymbol()

                        let exchange = try await service.getNBPData(table: .a, symbol: symbol , from: from, to: today)
                        let cashExchangeRates = try await service.getNBPData(table: .c, symbol: symbol, from: from, to: today).rates
                           
                        await send(.updatePeriod(date))
                        await send(.updateExchangeData(exchange))
                        await send(.updateCashExchangeRatesData(cashExchangeRates as! [RatesC]))
                    }
                    
                case .view(.viewDidAppear):
                    return .run { [date = state.dateForm, symbol = state.selectedCurrency] send in
                        let from = date.chartRangeStartDate
                        let today = Date()
                        let symbol = symbol.changeGCSymbol()
                        
                        let exchange = try await service.getNBPData(table: .a, symbol: symbol, from: from, to: today)
                        let cashExchangeRates = try await service.getNBPData(table: .c, symbol: symbol, from: from, to: today).rates
                        
                        await send(.updatePeriod(date))
                        await send(.updateExchangeData(exchange))
                        await send(.updateCashExchangeRatesData(cashExchangeRates as! [RatesC]))
                    }
                    
                case let .selectedCurrencyTabChange(selectedCurrency):
                    
                    return .run { [date = state.dateForm] send in
                        let from = date.chartRangeStartDate
                        let today = Date()
                        let symbol = selectedCurrency.changeGCSymbol()
                        
                        let exchange = try await service.getNBPData(table: .a, symbol: symbol , from: from, to: today)
                        let cashExchangeRates = try await service.getNBPData(table: .c, symbol: symbol, from: from, to: today).rates
                        
                        await send(.view(.updateCurrencyTab(selectedCurrency)))
                        await send(.updateExchangeData(exchange))
                        await send(.updateCashExchangeRatesData(cashExchangeRates as! [RatesC]))
                    }
                    
                case let .view(.selectedCurrencySymbolChange(globalSymbols)):
                    state.selectedCurrencySymbol = globalSymbols
                    return .none
                    
                case let .view(.updateCurrencyTab(mainCurrencyItem)):
                    state.selectedCurrency = mainCurrencyItem
                    return .none
                    
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
