//
//  CurrencyConverterFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

/// `CurrencyConverterFeature+Action`
extension CurrencyConverterFeature {
    
    @CasePathable
    enum Action: ViewAction {
        
        case selectedTransactionTypeChange(TransactionType)
        
        case convertAmount(String)
        
        case view(View)
        
        enum View {
            
            case selectedCurrencyType(GlobalCurrencySymbols)
            
            case selectedPaymentCurrencyType(GlobalCurrencySymbols)
        }
    }
    
}
