//
//  MainFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import ComposableArchitecture
import Foundation

/// `MainFeature+State`
extension MainFeature {

    @ObservableState
    struct State: Equatable {
        
        var selectedCurrencySymbol: GlobalCurrencySymbols = .polishZloty
        
        var selectedCurrency: MainCurrencyState = .euro
        
        var selectedTransitionTab: CurrencyTransactionType = .average
        
    }

}
