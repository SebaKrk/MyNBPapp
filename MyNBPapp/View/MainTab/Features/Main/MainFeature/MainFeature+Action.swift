//
//  MainFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Commons
import ComposableArchitecture
import DataModels
import Foundation

/// `MainFeature+Action`
extension MainFeature {
    
    @CasePathable
    enum Action: ViewAction {
        
        // MARK: Action
        
        case selectedTabTransactionChange(CurrencyTransactionType)
        
        case selectedCurrencyTabChange(MainCurrencyState)
        
        case updateExchangeData(Exchange)
        
        case updateCashExchangeRatesData([RatesC])
        
        case updatePeriod(PeriodsCurrencyOption)
        
        
        // MARK: View Action
        
        case view(View)
        
        enum View {
            
            case selectedCurrencySymbolChange(GlobalCurrencySymbols)
            
            case selectedPeriodChange(PeriodsCurrencyOption)
            
            case updateCurrencyTab(MainCurrencyState)
            
            case viewDidAppear
        
        }
        
        // MARK: Path
        
        case path(StackAction<ContainerRateDetailFeature.State, ContainerRateDetailFeature.Action>)
        
        // MARK: Children Action
        
        case currencyConverter(CurrencyConverterFeature.Action)
    }
    
}
