//
//  TestFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import Foundation
import ComposableArchitecture

/// `TestFeature+Reducer
@Reducer
struct TestFeature {
    
    // MARK: - Typealias
    
    typealias FeatureState = TestFeature.State
    typealias FeatureAction = TestFeature.Action
    
    // MARK: Properties
    
    let service = TestFeatureServices()
        
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action {
            case .view(.userTapedTestButton):
                print("test")
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            TestFeature2()
        }

    }

}
