//
//  RootFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import SwiftUI

/// Implementation of `WidgetListFeature` state
extension RootFeature {
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        
        @Presents var destination: Destination.State?
    }
    
}
