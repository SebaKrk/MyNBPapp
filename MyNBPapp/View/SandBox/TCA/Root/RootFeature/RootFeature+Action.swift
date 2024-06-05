//
//  RootFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import Foundation

/// Implementation of `WidgetListFeature` action
extension RootFeature {
    
    @CasePathable
    enum Action {
        ///case goBackToScreen(id: StackElementID)
        case goToAAAButtonTapped
        case path(StackActionOf<Path>)
        case popToRoot
        
        case favoritesButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }
    
}
