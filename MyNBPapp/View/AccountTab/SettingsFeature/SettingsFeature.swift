//
//  SettingsFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

/// `SettingsFeature+Reducer`
@Reducer
struct SettingsFeature {
    
    // MARK: - Typealias
    
    typealias FeatureState = SettingsFeature.State
    typealias FeatureAction = SettingsFeature.Action
    
    // MARK: Properties
    
    let service = SettingsFeatureServices()

    // MARK: - Dependencies

    @Dependency(\.dismiss) var dismiss
    
    // MARK: - Reducer
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .view(.userTapedDoneButton):
                print("userTapedDoneButton")
                return .none
            case .view(.userTapedCancelButton):
                print("userTapedCancelButton")
                return .run { _ in
                    await dismiss()
                }
            }
        }
    }

}
