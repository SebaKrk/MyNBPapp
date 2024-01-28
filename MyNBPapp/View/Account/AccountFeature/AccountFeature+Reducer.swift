//
//  AccountFeature+Reducer.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

extension AccountFeature: Reducer {
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .userTappedSettingsButton:
                state.isSettingsSheetPresented = true
                return .none
                
            case .settingsSheetPresented(let isPresented):
                state.isSettingsSheetPresented = isPresented
                return .none
            }
        }
    }
    
}
