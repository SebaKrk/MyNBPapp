//
//  MainFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import ComposableArchitecture
import Foundation

/// `MainFeature+Action`
extension MainFeature {
    
    @CasePathable
    enum Action: ViewAction {
            
        case selectedTabChange(CurrencyTransactionType)
        
        case selectedCurrencyTabChange(MainCurrencyState)
        
        case view(View)
        
        enum View {
            
            case selectedCurrencySymbolChange(GlobalCurrencySymbols)
            
            case viewDidAppear
        
        }
    }
    
}
