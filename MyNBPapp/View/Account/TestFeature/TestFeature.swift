//
//  TestFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TestFeature {
    
    // MARK: - Typealias
    
    typealias FeatureState = TestFeature.State
    typealias FeatureAction = TestFeature.Action
    
    // MARK: Properties
    
    let service = TestFeatureServices()
    
}
