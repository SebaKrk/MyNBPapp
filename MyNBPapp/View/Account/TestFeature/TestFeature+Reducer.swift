//
//  TestFeature+Reducer.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import ComposableArchitecture
import Foundation

extension TestFeature {
    
    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action {
                
            case .view(.userTapedTestButton):
                print("test")
                return .none
            }
        }
    }
    
}
