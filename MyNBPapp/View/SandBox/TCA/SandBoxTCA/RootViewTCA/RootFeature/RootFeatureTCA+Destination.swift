//
//  RootFeatureTCA+Destination.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import ComposableArchitecture

extension RootFeatureTCA {
    
    @Reducer(state: .equatable)
    enum Destination {
        case openNewScreen(SandBoxStarFeature)
    }
    
}
