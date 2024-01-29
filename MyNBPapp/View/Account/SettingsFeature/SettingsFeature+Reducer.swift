//
//  SettingsFeature+Reducer.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

extension SettingsFeature: Reducer {
     
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .userTapedDoneButton:
                print("userTapedDoneButton")
                return .none
                
            case .userTapedCancelButton:
                print("userTapedCancelButton")
                return .run { _ in
                   await dismiss()
                }
                
            }
        }
    }
    
}
