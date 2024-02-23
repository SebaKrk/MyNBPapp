//
//  SettingsFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SettingsFeature {
    
    // MARK: - Typealias
    
    typealias FeatureState = SettingsFeature.State
    typealias FeatureAction = SettingsFeature.Action
    
    // MARK: Properties
    
    let service = SettingsFeatureServices()

    // MARK: - Dependencies

    @Dependency(\.dismiss) var dismiss

}
