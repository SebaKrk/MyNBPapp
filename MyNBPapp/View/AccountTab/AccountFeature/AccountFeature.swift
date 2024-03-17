//
//  AccountFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

/// `AccountFeature+Reducer
@Reducer
struct AccountFeature {
    
    // MARK: - Typealias
    
    typealias FeatureState = AccountFeature.State
    typealias FeatureAction = AccountFeature.Action
    
    // MARK: Properties
    
    let service = AccountFeatureServices()
    
    // MARK: - Reducer
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .view(.userTappedSettingsButton):
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
