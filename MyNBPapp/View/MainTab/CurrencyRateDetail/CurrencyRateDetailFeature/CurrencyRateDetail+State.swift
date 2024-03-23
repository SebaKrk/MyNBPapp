//
//  CurrencyRateDetail+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 18/03/2024.
//

import ComposableArchitecture
import DataModels
import Foundation

/// `CurrencyRateDetail+State`
extension CurrencyRateDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        var exchange: Exchange?
    }
    
}
