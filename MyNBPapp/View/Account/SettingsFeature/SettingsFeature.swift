//
//  SettingsFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Factory
import Foundation

@Reducer
struct SettingsFeature {
 
    // MARK: - Dependencies
    
    @Dependency(\.dismiss) var dismiss

}
