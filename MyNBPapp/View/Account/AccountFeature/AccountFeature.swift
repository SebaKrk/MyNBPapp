//
//  AccountFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/01/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AccountFeature {
    
    // MARK: - Typealias
    
    typealias FeatureState = AccountFeature.State
    typealias FeatureAction = AccountFeature.Action
    
    // MARK: Properties
    
    let service = AccountFeatureServices()
    
}
