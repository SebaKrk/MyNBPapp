//
//  AccountFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

/// `AccountFeature+State`
extension AccountFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var isSettingsSheetPresented: Bool = false
        
        @Presents var settingsFeature: SettingsFeature.State?
        
    }
    
}
