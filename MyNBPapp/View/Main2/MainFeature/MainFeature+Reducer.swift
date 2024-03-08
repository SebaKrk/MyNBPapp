//
//  MainFeature+Reducer.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import ComposableArchitecture
import Foundation

/// `MainFeature+Reducer`
extension MainFeature {
    
    var body: some ReducerOf<Self> {
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
                print("Strzał po dane")
                return .none
            }
        }
    }
    
}
