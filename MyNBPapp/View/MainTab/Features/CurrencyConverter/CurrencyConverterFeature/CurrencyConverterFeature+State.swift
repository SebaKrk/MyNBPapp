//
//  CurrencyConverterFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Commons
import Foundation

/// `CurrencyConverterFeature+State`
extension CurrencyConverterFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var selectedTransactionType: TransactionType = .buy
        
        var currencySelectType: GlobalCurrencySymbols = .polishZloty
        
        var paymentCurrencyType: GlobalCurrencySymbols = .euro
        
        var amount: String = ""
        
        var convertedAmount: Double? = nil
        
        var isMultipleSourcesEnabled: Bool = false
        
    }
}
