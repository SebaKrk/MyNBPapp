//
//  CurrencyConverterFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import Commons
import ComposableArchitecture
import Foundation

/// `CurrencyConverterFeature+Reducer`
@Reducer
struct CurrencyConverterFeature { 
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            
            case let.selectedTransactionTypeChange(transactionType):
                state.selectedTransactionType = transactionType
                return .none
                
            case let .convertAmount(amount):
                if let convertedAmount = Double(amount) {
                    let kursEuro = 4.23
                    state.convertedAmount = convertedAmount * kursEuro
                }
                return .none
                
            case let .view(.selectedCurrencyType(currencySelected)):
                state.currencySelectType = currencySelected
                return .none
            
            case let .view(.selectedPaymentCurrencyType(paymentSelected)):
                state.paymentCurrencyType = paymentSelected
                return .none
            }
        }
    }
    
}
