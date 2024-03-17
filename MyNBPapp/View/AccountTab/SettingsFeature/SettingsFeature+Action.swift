//
//  SettingsFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//
import ComposableArchitecture
import Foundation

/// `SettingsFeature+Action`
extension SettingsFeature {
    
    @CasePathable
    enum Action: ViewAction {
        
        case view(View)
        
        enum View {
            
            case userTapedDoneButton
            
            case userTapedCancelButton
            
        }
    }
    
}
