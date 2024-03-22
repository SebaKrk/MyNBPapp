//
//  MainFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Commons
import ComposableArchitecture
import Foundation

/// `MainFeature+Action`
extension MainFeature {
    
    @CasePathable
    enum Action: ViewAction {
        
        // MARK: Action
        case selectedTabChange(CurrencyTransactionType)
        
        case selectedCurrencyTabChange(MainCurrencyState)
        
        // MARK: View Action
        case view(View)
        
        enum View {
            
            case selectedCurrencySymbolChange(GlobalCurrencySymbols)
            
            case viewDidAppear
        
        }
        
        // MARK: Children Action
        case currencyConverter(CurrencyConverterFeature.Action)
    }
    
}
