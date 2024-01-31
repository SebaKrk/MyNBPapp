//
//  AccountFeature+Reducer.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

extension AccountFeature {
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .userTappedSettingsButton:
                return .run { send in
                    await send(.settingsSheetPresented)
                }
                
            case .settingsSheetPresented:
                state.settingsFeature = .init()
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$settingsFeature, action: \.settingsFeature) {
            SettingsFeature()
        }
    }
    
}
