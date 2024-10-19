//
//  RootFeatureTCA+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import ComposableArchitecture

extension RootFeatureTCA {
    
    @ObservableState
    struct State: Equatable {
        
        // MARK: Path
        
        var path = StackState<Path.State>()
        
        // MARK: Children state
        
        var sandBoxCFeature = SandBoxC.State()
        
        @Presents
        var destination: Destination.State?
    }
}

