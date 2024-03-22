//
//  TestFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import ComposableArchitecture
import Foundation

/// `TestFeature+State`
extension TestFeature {
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<TestFeature2.State>()
    }
    
}
