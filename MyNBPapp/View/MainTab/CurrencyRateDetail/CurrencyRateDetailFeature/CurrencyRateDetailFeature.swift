//
//  CurrencyRateDetailFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

/// `CurrencyRateDetail+Reducer`
@Reducer
struct CurrencyRateDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    @CasePathable
    enum Action {
        
    }
    
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
    
}

///// `CurrencyRateDetail+Action
//extension CurrencyRateDetailFeature { }
//
//
///// `CurrencyRateDetail+State
//extension CurrencyRateDetailFeature { }
