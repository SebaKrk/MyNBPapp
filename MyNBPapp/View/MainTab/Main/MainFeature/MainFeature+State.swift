//
//  MainFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Commons
import ComposableArchitecture
import DataModels
import Foundation

///// `MainFeature+State`
extension MainFeature {

    @ObservableState
    struct State: Equatable {
    
        // MARK: Properties
        var exchange: Exchange?
        
        var selectedCurrencySymbol: GlobalCurrencySymbols = .polishZloty
        
        var selectedCurrency: MainCurrencyState = .euro
        
        var selectedTransitionTab: CurrencyTransactionType = .average
        
        var dateForm: CalendarCurrencyOption = .month
        
        // MARK: Path
        
        var path = StackState<CurrencyRateDetailFeature.State>()
        
        // MARK: Children state
        
        var currencyConverter = CurrencyConverterFeature.State()
        
        
        // MARK: - Equatable
        
        static func == (lhs: MainFeature.State, rhs: MainFeature.State) -> Bool {
            lhs.exchange == rhs.exchange &&
            lhs.exchange?.code == rhs.exchange?.code
        }
    }

}
