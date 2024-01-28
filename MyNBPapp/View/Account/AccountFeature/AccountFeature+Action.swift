//
//  AccountFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import Foundation

extension AccountFeature {
    
    enum Action: Equatable {
        case userTappedSettingsButton
        case settingsSheetPresented(Bool)
    }
    
}
