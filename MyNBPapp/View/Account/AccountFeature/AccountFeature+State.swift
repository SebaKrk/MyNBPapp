//
//  AccountFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

extension AccountFeature {
    
    struct State: Equatable {
        
        var isSettingsSheetPresented: Bool = false
        
        @PresentationState var settingsFeature: SettingsFeature.State?
        
    }
    
}
