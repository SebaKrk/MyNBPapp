//
//  RootFeatureTCA+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import ComposableArchitecture

extension RootFeatureTCA {
    
    @CasePathable
    enum Action {
        
        case path(StackActionOf<Path>)
        
        case goToViewAAA
        
        //case gotoViewB
        
        case destination(PresentationAction<Destination.Action>)
        
        case starButtonTapped
        
        // case popToRoot
        
        // MARK: Children Action
         case sandBoxCFeature(SandBoxC.Action)
        
    }
}
