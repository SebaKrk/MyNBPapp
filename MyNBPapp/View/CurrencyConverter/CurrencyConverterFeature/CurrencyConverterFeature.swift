//
//  CurrencyConverterFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CurrencyConverterFeature { 
    
    /// `CurrencyConverterFeature+State`
    @ObservableState
    struct State: Equatable {
        
        var selectedTransactionType: TransactionType = .buy
        
        var currencySelectType: GlobalCurrencySymbols = .polishZloty
        
        var paymentCurrencyType: GlobalCurrencySymbols = .euro
        
        var amount: String = ""
        
        var convertedAmount: Double? = nil
        
        var isMultipleSourcesEnabled: Bool = false
        
    }
    
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
