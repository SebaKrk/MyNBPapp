//
//  PickerFeatureTCA+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 10/12/2024.
//

import ComposableArchitecture
import DataModels

extension PickerFeatureTCA {
    
    @ObservableState
    struct State: Equatable {
        
        var exchange: Exchange? = nil
        
        var periods: Periods? = nil
        
        var selectedPeriod: Period?
    }
    
}
