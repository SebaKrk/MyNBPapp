//
//  AccountFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

extension AccountFeature {
    
    @CasePathable
    enum Action: ViewAction {
        
        case settingsSheetPresented
        
        case settingsFeature(PresentationAction<SettingsFeature.Action>)
        
        case view(View)
        
        enum View {
            
            case userTappedSettingsButton
            
        }
    }
    
}
