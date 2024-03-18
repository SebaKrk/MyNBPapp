//
//  TestFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import ComposableArchitecture
import Foundation

/// `TestFeature+Action
extension TestFeature {
    
    @CasePathable
    enum Action: ViewAction {
        
        case view(View)
        
        enum View {
            case userTapedTestButton
        }
        
        case path(StackAction<TestFeature2.State, TestFeature2.Action>)
    }
    
}
