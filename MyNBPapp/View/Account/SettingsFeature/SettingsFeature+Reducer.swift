//
//  SettingsFeature+Reducer.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

extension SettingsFeature {
    
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
